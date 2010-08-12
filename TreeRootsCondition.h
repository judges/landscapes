//
//  TreeRootsCondition.h
//  landscapes
//
//  Created by Evan Cordell on 8/12/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Photo.h"

@class AssessmentTree;

@interface TreeRootsCondition :  Photo  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AssessmentTree * tree;

@end



