//
//  AssessmentTableViewController.h
//  landscapes
//
//  Created by Evan Cordell on 7/26/10.
//  Copyright National Park Service/NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AssessmentTableViewCell.h"

//needed to prepopulated the db
#import "Assessment.h"
#import "Landscape.h"
#import "AssessmentTree.h"
#import "AssessmentType.h"
#import "TreeCrownCondition.h"
#import "TreeCrownRecommendation.h"
#import "TreeFormCondition.h"
#import "TreeFormRecommendation.h"
#import "TreeOverallCondition.h"
#import "TreeOverallRecommendation.h"
#import "TreeRootFlareCondition.h"
#import "TreeRootFlareRecommendation.h"
#import "TreeRootsCondition.h"
#import "TreeRootsRecommendation.h"
#import "TreeTrunkCondition.h"
#import "TreeTrunkRecommendation.h"


@interface AssessmentTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate> {
    @private
        NSFetchedResultsController *fetchedResultsController;
        NSManagedObjectContext *managedObjectContext;
    
}
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(AssessmentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)prepopulateDb;
@end
