//
//  DisplayPhoto.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "DisplayPhoto.h"


@implementation DisplayPhoto
@synthesize caption = _caption;
@synthesize photoSource = _photoSource;
@synthesize index = _index;
@synthesize image = _image;

- (id)initWithCaption:(NSString *)caption image:(NSData *)image{
    if ((self = [super init])) {
        self.caption = caption;
        self.image = image;
        self.index = NSIntegerMax;
        self.photoSource = nil;
    }
    return self;
}

- (void) dealloc {
    self.caption = nil;
    [super dealloc];
}

#pragma mark TTPhoto

- (NSString*)URLForVersion:(TTPhotoVersion)version {
    switch (version) {
        case TTPhotoVersionLarge:
            return nil;
        case TTPhotoVersionMedium:
            return nil;
        case TTPhotoVersionSmall:
            return nil;
        case TTPhotoVersionThumbnail:
            return nil;
        default:
            return nil;
    }
}

@end
