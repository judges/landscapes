//
//  PhotoViewController.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoSet.h"
#import "DisplayPhoto.h"

@implementation PhotoViewController
@synthesize photoSet = _photoSet;
@synthesize count, entityString, objID, photos, ids;

-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    //initializes and passes assessment from parent controller

	
    if (self = [super init]){ 
        if(query && [query objectForKey:@"entity"]){ 
            self.entityString = (NSString*) [query objectForKey:@"entity"]; 
        } 
        if(query && [query objectForKey:@"objectID"]){ 
            self.objID = (NSManagedObjectID*) [query objectForKey:@"objectID"]; 
        } 
        photos = [[NSMutableArray alloc] init];
        ids = [[NSMutableArray alloc] init];
    } 
    return self;    
}

-(void)addPhotosFromObjectString:(NSString *)objectString withId:(NSManagedObjectID *)theId andComparator:(NSString *)comparator {
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Set the entity we're requesting
    NSEntityDescription *entity = [NSEntityDescription entityForName:objectString inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    //Grab the object that's identified by theId, equal to a comparator
    if (![entityString isEqualToString:@"Photo"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@", theId];
        [fetchRequest setPredicate:predicate]; 
    }

    //fetch the objects
    NSError *error;
    NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    for (NSManagedObject *item in fetchedObjects)
    {
        if ([item.entity.propertiesByName objectForKey:@"images"]) {
            [self addPhotos:((Photo *)item).images];
            
            
            //fetch children, filtered by class type. 
            //This seems more hard coded than it should be, but it's actually the best way.
            if ([objectString isEqualToString:@"AssessmentTree"]) {
                [self addPhotos:((AssessmentTree *)item).form.images];
                [self addPhotos:((AssessmentTree *)item).crown.images];
                [self addPhotos:((AssessmentTree *)item).trunk.images];
                [self addPhotos:((AssessmentTree *)item).rootflare.images];
                [self addPhotos:((AssessmentTree *)item).roots.images];
                [self addPhotos:((AssessmentTree *)item).overall.images];
            }
        }
    }
    [fetchRequest release];
}

- (void) addPhotos:(NSSet *)arr {
    for (Image *image in arr) {
        [photos addObject:image.image_data];
        [ids addObject:image.objectID];
    }
}

- (void) viewDidLoad {
    //if called from launcher, show all photos
    if (!self.entityString) {
        self.entityString = @"Photo";
    } 
    [self addPhotosFromObjectString:self.entityString withId:self.objID andComparator:@"self"];

    self.photoSource = [[PhotoSet alloc] initWithTitle:@"Photos" photos:photos ids:ids];
    count = [photos count];    
    
    //Override stuff from parent class
    self.navigationBarTintColor = [UIColor colorWithRed:0.180 green:0.267 blue: 0.173 alpha:1.0];
    UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                         UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    _deleteButton = [[UIBarButtonItem alloc] initWithImage:
                     TTIMAGE(@"bundle://icon_trash.png") 
                     style:UIBarButtonItemStylePlain target:self action:@selector(deleteAction)];
    _toolbar.items = [NSArray arrayWithObjects: space, space, _previousButton, space, _nextButton, space, _deleteButton, nil];
    _toolbar.tintColor = [UIColor colorWithRed:0.180 green:0.267 blue: 0.173 alpha:1.0];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex == [actionSheet cancelButtonIndex])
    {
        [_photoSource deletePhotoAtIndex:_scrollView.centerPageIndex];
        [self showActivity:nil];
        [self moveToNextValidPhoto];
        [_scrollView reloadData];
        [self refresh];
    }
}

- (void)deleteAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] 
                                  initWithTitle:@"Are you sure you want to delete this photo?" delegate:self cancelButtonTitle:@"Cancel" 
                                  destructiveButtonTitle:@"OK" otherButtonTitles: nil];

    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void) viewDidDisappear:(BOOL)animated {
    //Find the right place to unload this stuff!
    
    for(int i = 0; i < self.count; ++i) {
        NSString *path = [NSString stringWithFormat:@"images/%d.jpg",i];
        NSString *url = [NSString stringWithFormat:@"temp://%@", path];
        [[TTURLCache sharedCache] removeURL:url fromDisk:YES];
    } 
}

- (void) dealloc {
    for (DisplayPhoto *p in self.photoSet.photos) {
        [p release];
    }
    [photos release];
    [ids release];
    [_deleteButton release];
    self.photoSet = nil; 
    self.count = 0;
    [self.photoSet release];
    [self.entityString release];
    [super dealloc];
}

@end