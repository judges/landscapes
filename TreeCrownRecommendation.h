//
//  TreeCrownRecommendation.h
//  landscapes
//
//  Created by Evan Cordell on 8/11/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>

@class AssessmentTree;

@interface TreeCrownRecommendation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AssessmentTree * tree;

@end



