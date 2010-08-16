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

@interface PhotoViewController : TTPhotoViewController <UIActionSheetDelegate> {
    PhotoSet *_photoSet;
    int count;
    NSString *entityString;
    NSManagedObjectID *objID;
    NSMutableArray *photos;
    NSMutableArray *ids;
    UIBarButtonItem* _deleteButton;
}
@property (nonatomic, assign) int count;
@property (nonatomic, retain) PhotoSet *photoSet;
@property (nonatomic, copy) NSString *entityString;
@property (nonatomic, retain) NSManagedObjectID *objID;
@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) NSMutableArray *ids;
-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query;
-(void)deleteAction;
-(void)addPhotosFromObjectString:(NSString *)objectString withId:(NSManagedObjectID *)theId andComparator:(NSString * )comparator;
-(void)addPhotos:(NSSet *)arr;
@end
