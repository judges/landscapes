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

@interface AssessmentTreeCRViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate> {
    IBOutlet UIView *conditionView;
    IBOutlet UIView *recommendationView;
    IBOutlet UIPickerView *conditionPicker;
    IBOutlet UIPickerView *recommendationPicker;
    IBOutlet UISegmentedControl *switchControl;
    NSMutableArray *conditionArray;
    NSMutableArray *recommendationArray;
    NSNumber *whichId;
    @private
        NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, retain) NSNumber *whichId;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *conditionArray;
@property (nonatomic, retain) NSMutableArray *recommendationArray;
-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query;
-(IBAction)segmentSwitch:(id)sender;
@end
