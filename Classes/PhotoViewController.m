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

- (void) viewDidLoad {
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Grab AssessmentTree that matches the Assessment.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AssessmentTree" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assessment == %@", self.assessment];
    //[fetchRequest setPredicate:predicate];
    
    // sort by assessment
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"assessment" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for(AssessmentTree *tree in fetchedObjects)
    {
        for (Image *image in tree.images)
        {
            [photos addObject:image.image_data];
        }
    }
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    self.photoSource = [[PhotoSet alloc] initWithTitle:@"Photos" photos:photos];
    //[photos release];
}

- (void) dealloc {
    self.photoSet = nil;    
    [super dealloc];
}

@end