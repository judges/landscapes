//
//  AssessmentViewAndInput.h
//  landscapes
//
//  Created by Evan Cordell on 8/2/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"

@interface AssessmentTreeViewAndInputController : UIViewController {
    Assessment *assessment;
    IBOutlet UILabel *assessor;
}
@property (nonatomic, retain) Assessment *assessment;
@property (nonatomic, retain) UILabel *assessor;
-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query;
@end
