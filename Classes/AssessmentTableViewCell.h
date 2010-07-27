//
//  AssessmentTableViewCell.h
//  landscapes
//
//  Created by Evan Cordell on 7/27/10.
//  Copyright National Park Service/NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"

@interface AssessmentTableViewCell : UITableViewCell {
    Assessment *assessment;
    
    UILabel *landscapeName;
    UILabel *typeName;
}

@property (nonatomic, retain) Assessment *assessment;
@property (nonatomic, retain) UILabel *landscapeName;
@property (nonatomic, retain) UILabel *typeName;

@end
