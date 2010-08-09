//
//  DisplayPhoto.h
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

//The Photo class represents the Photo object in the DB, while the DisplayPhoto 
//class represents the photos used by TTPhoto to display in the Photo View
@interface DisplayPhoto : NSObject <TTPhoto> {
    NSString *_caption;
    NSData *_image;
    id <TTPhotoSource> _photoSource;
    NSInteger _index;
}

@property (nonatomic, copy) NSString *caption;
@property (nonatomic, assign) id <TTPhotoSource> photoSource;
@property (nonatomic) NSInteger index;
@property (nonatomic, retain) NSData* image;
- (id)initWithCaption:(NSString *)caption image:(NSData *)image;

@end
