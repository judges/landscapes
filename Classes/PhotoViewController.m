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
@synthesize count, entityString;

-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    //initializes and passes assessment from parent controller
    if (self = [super init]){ 
        if(query && [query objectForKey:@"entity"]){ 
            self.entityString = (NSString*) [query objectForKey:@"entity"]; 
        } 
    } 
    return self;    
}

- (void) viewDidLoad {
    //if called from launcher, show all photos
    if (!self.entityString) {
        self.entityString = @"Photo";
    }
    NSMutableArray *photos = [[NSMutableArray alloc] init];
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
            }
            //grab images one level down. This will need to be changed to some sort of
            //recursive function if we add another level in the future.
            if (![self.entityString isEqualToString:@"Photo"]) {
                for (NSString *sub in property.entity.relationshipsByName)
                {
                    NSLog(@"///////////Property: %@////////////", sub);
                    NSRelationshipDescription *rel = [property.entity.relationshipsByName objectForKey:sub];
                    NSLog(@"%@", [rel.destinationEntity.relationshipsByName objectForKey:@"images"]);
                    if ([rel.destinationEntity.relationshipsByName objectForKey:@"images"] && ![sub isEqualToString:@"assessment"]) {
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
    
    self.photoSource = [[PhotoSet alloc] initWithTitle:@"Photos" photos:photos];
    count = [photos count];
    [photos release];
}

- (void) viewDidDisappear:(BOOL)animated {
    //Find the right place to unload this stuff!
    /*
    for(int i = 0; i < self.count; ++i) {
        NSString *path = [NSString stringWithFormat:@"images/%d.jpg",i];
        NSString *url = [NSString stringWithFormat:@"temp://%@", path];
        [[TTURLCache sharedCache] removeURL:url fromDisk:YES];
    } */
}

- (void) dealloc {
    self.photoSet = nil; 
    self.count = 0;
    [self.photoSet release];
    [self.entityString release];
    [super dealloc];
}

@end