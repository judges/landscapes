//
//  AssessmentViewAndInput.h
//  landscapes
//
//  Created by Evan Cordell on 8/2/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"
#import "AssessmentTree.h"
#import "AppDelegate.h"

@interface AssessmentTreeViewAndInputController : UIViewController <NSFetchedResultsControllerDelegate> {
    Assessment *assessment;
    AssessmentTree *assessmentTree;
    IBOutlet UILabel *assessor;
    IBOutlet UILabel *date;
    IBOutlet UILabel *caliper;
    IBOutlet UILabel *height;
    IBOutlet UILabel *formCText;
    IBOutlet UILabel *crownCText;
    IBOutlet UILabel *trunkCText;
    IBOutlet UILabel *rootFlareCText;
    IBOutlet UILabel *rootsCText;
    IBOutlet UILabel *overallCText;
    IBOutlet UILabel *formRText;
    IBOutlet UILabel *crownRText;
    IBOutlet UILabel *trunkRText;
    IBOutlet UILabel *rootFlareRText;
    IBOutlet UILabel *rootsRText;
    IBOutlet UILabel *overallRText;
    
 @private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, retain) Assessment *assessment;
@property (nonatomic, retain) AssessmentTree *assessmentTree;
@property (nonatomic, retain) UILabel *assessor;
@property (nonatomic, retain) UILabel *date;
@property (nonatomic, retain) UILabel *caliper;
@property (nonatomic, retain) UILabel *height;
@property (nonatomic, retain) UILabel *formCText;
@property (nonatomic, retain) UILabel *crownCText;
@property (nonatomic, retain) UILabel *trunkCText;
@property (nonatomic, retain) UILabel *rootFlareCText;
@property (nonatomic, retain) UILabel *rootsCText;
@property (nonatomic, retain) UILabel *overallCText;
@property (nonatomic, retain) UILabel *formRText;
@property (nonatomic, retain) UILabel *crownRText;
@property (nonatomic, retain) UILabel *trunkRText;
@property (nonatomic, retain) UILabel *rootFlareRText;
@property (nonatomic, retain) UILabel *rootsRText;
@property (nonatomic, retain) UILabel *overallRText;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query;
@end
