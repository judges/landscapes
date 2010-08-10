//
//  PhotoSet.h
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface PhotoSet : TTURLRequestModel <TTPhotoSource> {
    NSString *_title;
    NSMutableArray *_photos;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *photos;

- (id) initWithTitle:(NSString *)title photos:(NSMutableArray *)photos;

@end