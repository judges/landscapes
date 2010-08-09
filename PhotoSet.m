//
//  PhotoSet.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "PhotoSet.h"
#import "DisplayPhoto.h"

@implementation PhotoSet
@synthesize title = _title;
@synthesize photos = _photos;

- (id) initWithTitle:(NSString *)title photos:(NSArray *)photos {
    if ((self = [super init])) {
        self.title = title;
        self.photos = photos;
        for(int i = 0; i < _photos.count; ++i) {
            DisplayPhoto *photo = [_photos objectAtIndex:i];
            photo.photoSource = self;
            photo.index = i;
        }        
    }
    return self;
}

- (void) dealloc {
    self.title = nil;
    self.photos = nil;    
    [super dealloc];
}

#pragma mark TTModel

- (BOOL)isLoading { 
    return FALSE;
}

- (BOOL)isLoaded {
    return TRUE;
}

#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos {
    return _photos.count;
}

- (NSInteger)maxPhotoIndex {
    return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    if (photoIndex < _photos.count) {
        return [_photos objectAtIndex:photoIndex];
    } else {
        return nil;
    }
}

static PhotoSet *testPhotoSet = nil;

+ (PhotoSet *) testPhotoSet {
    @synchronized(self) {
        if (testPhotoSet == nil) {
            NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];

            
            // Create the fetch request for the entity.
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            // Grab AssessmentTree that matches the Assessment.
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"AssessmentTree" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // sort by assessment
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"assessment" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
            
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            NSError *error;
            NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            
            [fetchRequest release];
            [sortDescriptor release];
            [sortDescriptors release];
            
            NSMutableArray *photos = [NSMutableArray array]; 
            
            for(AssessmentTree *tree in fetchedObjects)
            {
                if (tree.image!=nil) {
                    [photos addObject:[[DisplayPhoto alloc] initWithCaption:tree.image_caption image:tree.image]];                                                                                      
                }
            }
            
            testPhotoSet = [[self alloc] initWithTitle:@"Photos" photos:photos];
        }
    }
    return testPhotoSet;
}
@end
