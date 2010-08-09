//
//  TreeRootFlareCondition.h
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Photo.h"

@class AssessmentTree;

@interface TreeRootFlareCondition :  Photo  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AssessmentTree * tree;

@end



