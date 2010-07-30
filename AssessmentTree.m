// 
//  AssessmentTree.m
//  landscapes
//
//  Created by Evan Cordell on 7/30/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AssessmentTree.h"

#import "Assessment.h"
#import "TreeCrownCondition.h"
#import "TreeCrownRecommendation.h"
#import "TreeFormCondition.h"
#import "TreeFormRecommendation.h"
#import "TreeOverallCondition.h"
#import "TreeOverallRecommendation.h"
#import "TreeRootFlareCondition.h"
#import "TreeRootFlareRecommendation.h"
#import "TreeRootsCondition.h"
#import "TreeRootsRecommendation.h"
#import "TreeTrunkCondition.h"
#import "TreeTrunkRecommendation.h"

@implementation AssessmentTree 

@dynamic id;
@dynamic caliper;
@dynamic height;
@dynamic form_condition_id;
@dynamic trunk_condition_id;
@dynamic rootflare_recommendation_id;
@dynamic rootflare_condition_id;
@dynamic crown_condition_id;
@dynamic assessment_id;
@dynamic crown_recommendation_id;
@dynamic trunk_recommendation_id;
@dynamic overall_recommendation_id;
@dynamic roots_condition_id;
@dynamic roots_recommendation_id;
@dynamic overall_condition_id;
@dynamic form_recommendation_id;

@end
