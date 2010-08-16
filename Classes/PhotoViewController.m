//
//  PhotoViewController.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoSet.h"

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
    if ([comparator isEqualToString:@"self"]) {
        //a hack because predicates don't let us dynamically set a key of self for some reason.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@", theId];
        [fetchRequest setPredicate:predicate];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", comparator, theId];
        [fetchRequest setPredicate:predicate];
    }
    

    //fetch the objects
    NSError *error;
    NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    for (NSManagedObject *item in fetchedObjects)
    {
        if ([item.entity.propertiesByName objectForKey:@"images"]) {
            for (Image *image in ((Photo *)item).images)
            {
                [photos addObject:image.image_data];
                [ids addObject:image.objectID];
            }
            //fetch children
            //have to hardcode
            
        }
    }
    [fetchRequest release];
}

- (void) viewDidLoad {
    //if called from launcher, show all photos
    if (!self.entityString) {
        self.entityString = @"Photo";
        NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Grab AssessmentTree that matches the Assessment.
        NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityString inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
        for (NSManagedObject *property in fetchedObjects)
        {
            if ([property.entity.propertiesByName objectForKey:@"images"]) {
                for (Image *image in ((Photo *)property).images)
                {
                    [photos addObject:image.image_data];
                    [ids addObject:image.objectID];
                }
            }
        }
        [fetchRequest release];
    } else {
        [self addPhotosFromObjectString:self.entityString withId:self.objID andComparator:@"self"];
    }

    
    /*
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Grab AssessmentTree that matches the Assessment.
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityString inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    //HACK HACK HACK
    if (![self.entityString isEqualToString:@"Photo"]) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@", objID];
            [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    NSLog(@"Fetched Objects: %@", fetchedObjects);
    for (NSManagedObject *property in fetchedObjects)
    {
        if ([property.entity.propertiesByName objectForKey:@"images"]) {
            for (Image *image in ((Photo *)property).images)
            {
                NSLog(@"TESTTEST");
                [photos addObject:image.image_data];
                [ids addObject:image.objectID];
            }
            //grab images one level down. This will need to be changed to some sort of
            //recursive function if we add another level in the future.
            
            if (![self.entityString isEqualToString:@"Photo"]) {
                for (NSString *sub in property.entity.relationshipsByName)
                {
                    NSLog(@"///////////Property: %@////////////", sub);
                    NSRelationshipDescription *rel = [property.entity.relationshipsByName objectForKey:sub];
                    NSLog(@"%@", [rel.destinationEntity.relationshipsByName objectForKey:@"images"]);
                    if ([rel.destinationEntity.relationshipsByName objectForKey:@"images"] && ![sub isEqualToString:@"assessment"] && ![sub isEqualToString:@"tree"] && ![sub isEqualToString:@"landscape"]) {
                        NSFetchRequest *subFetchRequest = [[NSFetchRequest alloc] init];
                        NSEntityDescription *entity = [NSEntityDescription entityForName:rel.destinationEntity.name inManagedObjectContext:managedObjectContext];
                        [subFetchRequest setEntity:entity];
                        NSLog(@"Entity Name: %@", entity.name);
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tree == %@", property];
                        NSLog(@"%@ == %@", property.entity.name, property);
                        [subFetchRequest setPredicate:predicate];
                        NSMutableArray *subFetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:subFetchRequest error:&error]];
                        for (NSManagedObject *subProperty in subFetchedObjects)
                        {
                            NSLog(@"///////////SubProperty////////////");
                            if ([subProperty.entity.propertiesByName objectForKey:@"images"]) {
                                NSLog(@"///////////Has Images////////////");
                                for (Image *subImage in ((Photo *)subProperty).images)
                                {
                                    NSLog(@"We have a subimage!");
                                    [photos addObject:subImage.image_data];
                                    [ids addObject:subImage.objectID];
                                }
                            }
                        }
                        [subFetchRequest release];
                    }
                    
                }
            }
            
        }
        
    }
    [fetchRequest release];
    */
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