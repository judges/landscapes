//
//  Assessment.h
//  landscapes
//
//  Created by Evan Cordell on 7/30/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Landscape;
@class AssessmentType;

@interface Assessment :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * assessor;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) Landscape * landscape_id;
@property (nonatomic, retain) AssessmentType * type_id;

@end



