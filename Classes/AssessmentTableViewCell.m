//
//  AssessmentTableViewCell.m
//  landscapes
//
//  Created by Evan Cordell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AssessmentTableViewCell.h"

@interface AssessmentTableViewCell (SubviewFrames)
- (CGRect)_landscapeNameFrame;
- (CGRect)_typeNameFrame;
@end

@implementation AssessmentTableViewCell

@synthesize assessment;
@synthesize landscapeName;
@synthesize typeName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        landscapeName = [[UILabel alloc] initWithFrame:CGRectZero];
        [landscapeName setFont:[UIFont systemFontOfSize:12.0]];
        [landscapeName setTextColor:[UIColor darkGrayColor]];
        [landscapeName setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:landscapeName];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [landscapeName setFrame:[self _landscapeNameFrame]];
    [typeName setFrame:[self _typeNameFrame]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGRect)_landscapeNameFrame {
    return CGRectMake(0, 0, 150, 20);
}
- (CGRect)_typeNameFrame {
    return CGRectMake(155, 0, 100, 20);
}

- (void)dealloc {
    [assessment release];
    [landscapeName release];
    [typeName release];
    [super dealloc];
}


@end
