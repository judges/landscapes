//
//  AssessmentTreeCRViewController.h
//  landscapes
//
//  Created by Evan Cordell on 8/3/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TreeFormCondition.h"
#import "TreeFormRecommendation.h"

@interface AssessmentTreeCRViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate> {
    AssessmentTree *tree;
    IBOutlet UIView *conditionView;
    IBOutlet UIView *recommendationView;
    IBOutlet UIPickerView *conditionPicker;
    IBOutlet UIPickerView *recommendationPicker;
    IBOutlet UISegmentedControl *switchControl;
    IBOutlet UIButton *conditionButton;
    IBOutlet UIButton *recommendationButton;
    IBOutlet UITextField *conditionField;
    IBOutlet UITextField *recommendationField;
    NSMutableArray *conditionArray;
    NSMutableArray *recommendationArray;
    NSNumber *whichId;
    @private
        NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, retain) AssessmentTree *tree;
@property (nonatomic, retain) NSNumber *whichId;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *conditionArray;
@property (nonatomic, retain) NSMutableArray *recommendationArray;
@property (nonatomic, retain) UITextField *conditionField;
@property (nonatomic, retain) UITextField *recommendationField;
-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query;
-(IBAction)addCondition;
-(IBAction)addRecommendation;
-(IBAction)conditionTypingFinished;
-(IBAction)recommendationTypingFinished;
-(IBAction)segmentSwitch:(id)sender;
@end
