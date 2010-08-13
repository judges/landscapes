//
//  TreeCrownRecommendation.h
//  landscapes
//
//  Created by Evan Cordell on 8/13/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>

@class AssessmentTree;

@interface TreeCrownRecommendation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* tree;

@end


@interface TreeCrownRecommendation (CoreDataGeneratedAccessors)
- (void)addTreeObject:(AssessmentTree *)value;
- (void)removeTreeObject:(AssessmentTree *)value;
- (void)addTree:(NSSet *)value;
- (void)removeTree:(NSSet *)value;

@end

