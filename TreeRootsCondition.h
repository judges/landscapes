//
//  TreeRootsCondition.h
//  landscapes
//
//  Created by Evan Cordell on 8/13/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Photo.h"

@class AssessmentTree;

@interface TreeRootsCondition :  Photo  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* tree;

@end


@interface TreeRootsCondition (CoreDataGeneratedAccessors)
- (void)addTreeObject:(AssessmentTree *)value;
- (void)removeTreeObject:(AssessmentTree *)value;
- (void)addTree:(NSSet *)value;
- (void)removeTree:(NSSet *)value;

@end

