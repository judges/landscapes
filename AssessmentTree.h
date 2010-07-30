//
//  AssessmentTree.h
//  landscapes
//
//  Created by Evan Cordell on 7/30/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Assessment;
@class TreeCrownCondition;
@class TreeCrownRecommendation;
@class TreeFormCondition;
@class TreeFormRecommendation;
@class TreeOverallCondition;
@class TreeOverallRecommendation;
@class TreeRootFlareCondition;
@class TreeRootFlareRecommendation;
@class TreeRootsCondition;
@class TreeRootsRecommendation;
@class TreeTrunkCondition;
@class TreeTrunkRecommendation;

@interface AssessmentTree :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDecimalNumber * caliper;
@property (nonatomic, retain) NSDecimalNumber * height;
@property (nonatomic, retain) TreeFormCondition * form_condition_id;
@property (nonatomic, retain) TreeTrunkCondition * trunk_condition_id;
@property (nonatomic, retain) TreeRootFlareRecommendation * rootflare_recommendation_id;
@property (nonatomic, retain) TreeRootFlareCondition * rootflare_condition_id;
@property (nonatomic, retain) TreeCrownCondition * crown_condition_id;
@property (nonatomic, retain) Assessment * assessment_id;
@property (nonatomic, retain) TreeCrownRecommendation * crown_recommendation_id;
@property (nonatomic, retain) TreeTrunkRecommendation * trunk_recommendation_id;
@property (nonatomic, retain) TreeOverallRecommendation * overall_recommendation_id;
@property (nonatomic, retain) TreeRootsCondition * roots_condition_id;
@property (nonatomic, retain) TreeRootsRecommendation * roots_recommendation_id;
@property (nonatomic, retain) TreeOverallCondition * overall_condition_id;
@property (nonatomic, retain) TreeFormRecommendation * form_recommendation_id;

@end



