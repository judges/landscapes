//
//  TreeRootsRecommendation.h
//  landscapes
//
//  Created by Evan Cordell on 8/12/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>

@class AssessmentTree;

@interface TreeRootsRecommendation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AssessmentTree * tree;

@end



