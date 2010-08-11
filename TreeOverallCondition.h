//
//  TreeOverallCondition.h
//  landscapes
//
//  Created by Evan Cordell on 8/11/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Photo.h"

@class AssessmentTree;

@interface TreeOverallCondition :  Photo  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AssessmentTree * tree;

@end



