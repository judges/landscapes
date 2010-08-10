//
//  PhotoViewController.h
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "AppDelegate.h"

@class PhotoSet;

@interface PhotoViewController : TTPhotoViewController {
    PhotoSet *_photoSet;
    int count;
    NSString *entityString;
}
@property (nonatomic, assign) int count;
@property (nonatomic, retain) PhotoSet *photoSet;
@property (nonatomic, copy) NSString *entityString;
-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query;
@end