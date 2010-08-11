//
//  PhotoSet.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "PhotoSet.h"
#import "DisplayPhoto.h"
#import "AppDelegate.h"

@implementation PhotoSet
@synthesize title = _title;
@synthesize photos = _photos;

- (id) initWithTitle:(NSString *)title photos:(NSMutableArray *)photos {
    if ((self = [super init])) {
        [[TTURLCache sharedCache] setMaxPixelCount:0];
        self.title = title;
        self.photos = [[NSMutableArray array] init];
        for(int i = 0; i < photos.count; ++i) {
            NSString *path = [NSString stringWithFormat:@"images/%d.jpg",i];
            UIImage *img = [UIImage imageWithData:[photos objectAtIndex:i]];
            NSString *url = [NSString stringWithFormat:@"temp://%@", path];
            [[TTURLCache sharedCache] storeImage:img forURL:url];
            DisplayPhoto *photo = [[[DisplayPhoto alloc] initWithCaption:@"Caption" urlLarge:url urlSmall:url urlThumb:url size:img.size] autorelease];
            photo.photoSource = self;
            photo.index = i;
            [self.photos addObject:photo];
        }        
    }
    return self;
}

- (void) dealloc {
    self.title = nil;
    self.photos = nil; 
    [self.photos release];
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
-(void)deletePhotoAtIndex:(NSInteger)index {
        if (index < _photos.count) {
            //Refactor so that entries can actually be deleted.
            /*
            NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSString *url = [NSString stringWithFormat:@"temp://images/%d.jpg", index];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"image_data LIKE %@",  UIImageJPEGRepresentation(TTIMAGE(url), 1.0)];
            [fetchRequest setPredicate:predicate];
            NSError *error;
            NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            for (Image *img in fetchedObjects) {
                [managedObjectContext deleteObject:img];
            }
            [fetchRequest release];
            */
            [_photos removeObjectAtIndex:index];
            
        }
}
@end
