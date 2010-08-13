//
//  LandscapesTableViewController.h
//  landscapes
//
//  Created by Sean Clifford on 8/12/10.
//  Copyright 2010 National Park Service/NCPTT. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "AppDelegate.h"
#import "Landscape.h"
#import <CoreData/CoreData.h>

@interface LandscapesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

