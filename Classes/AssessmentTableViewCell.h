//
//  AssessmentTableViewCell.h
//  landscapes
//
//  Created by Evan Cordell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AssessmentTableViewCell : UITableViewCell {
    UILabel *landscapeName;
    UILabel *typeName;
}

@property (nonatomic, retain) *landscapeName;
@property (nonatomic, retain) *typeName;

@end
