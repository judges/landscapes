//
//  Assessment.h
//  landscapes
//
//  Created by Evan Cordell on 7/30/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>

@class AssessmentType;
@class Landscape;

@interface Assessment :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * assessor;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) Landscape * landscape;
@property (nonatomic, retain) AssessmentType * type;

@end



