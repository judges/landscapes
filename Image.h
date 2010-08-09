//
//  Image.h
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Image :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * image_caption;
@property (nonatomic, retain) NSData * image_data;

@end



