//
//  AssessmentTableViewController.h
//  landscapes
//
//  Created by Evan Cordell on 7/26/10.
//  Copyright National Park Service/NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"
#import "AssessmentTableViewCell.h"
#import "AppDelegate.h"

@interface AssessmentTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    @private
        NSFetchedResultsController *fetchedResultsController;
        NSManagedObjectContext *managedObjectContext;
    
}
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
