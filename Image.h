//
//  Image.h
//  landscapes
//
//  Created by Evan Cordell on 8/11/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Image :  NSManagedObject  
{
}

@property (nonatomic, retain) NSData * image_data;
@property (nonatomic, retain) NSString * image_caption;

@end



