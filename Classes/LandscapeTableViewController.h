//
//  LandscapeTableViewController.h
//  landscapes
//
//  Created by Sean Clifford on 8/10/10.
//  Copyright 2010 National Park Service/NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Landscape;
@class LandscapeTableViewCell;

@interface LandscapeTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

	@private
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)showLandscape:(Landscape *)landscape animated:(BOOL)animated;
- (void)configureCell:(LandscapeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
