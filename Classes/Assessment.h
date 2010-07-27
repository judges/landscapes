//
//  Assessment.h
//  landscapes
//
//  Created by Evan Cordell on 7/27/10.
//  Copyright National Park Service/NCPTT 2010. All rights reserved.
//


//might not need this line
#import <Foundation/Foundation.h>


@interface Assessment : NSManagedObject {
}

@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, retain) NSString *assessor;
@property (nonatomic, retain) NSDate *created_at;

//foreign keys
@property (nonatomic, retain) NSNumber *landscape_id;
@property (nonatomic, retain) NSNumber *type_id;
@end
