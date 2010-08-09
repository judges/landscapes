//
//  PhotoSet.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "PhotoSet.h"
#import "DisplayPhoto.h"

@implementation PhotoSet
@synthesize title = _title;
@synthesize photos = _photos;

- (id) initWithTitle:(NSString *)title photos:(NSMutableArray *)photos {
    if ((self = [super init])) {
        [[TTURLCache sharedCache] setMaxPixelCount:0];
        self.title = title;
        self.photos = [[NSMutableArray array] init];
        for(int i = 0; i < photos.count; ++i) {
            NSString *path = [NSString stringWithFormat:@"images/%d.jpg",i];
            UIImage *img = [UIImage imageWithData:[photos objectAtIndex:i]];
            NSString *url = [NSString stringWithFormat:@"temp://%@", path];
            [[TTURLCache sharedCache] storeImage:img forURL:url];
            DisplayPhoto *photo = [[[DisplayPhoto alloc] initWithCaption:@"Caption" urlLarge:url urlSmall:url urlThumb:url size:img.size] autorelease];
            photo.photoSource = self;
            photo.index = i;
            NSLog(@"Image %d: %@:",i, photo);
            [self.photos addObject:photo];
        }        
    }
    NSLog(@"Images: %@, %@", self.photos, title);
    return self;
}

- (void) dealloc {
    self.title = nil;
    self.photos = nil;    
    [super dealloc];
}

#pragma mark TTModel

- (BOOL)isLoading { 
    return FALSE;
}

- (BOOL)isLoaded {
    return TRUE;
}

#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos {
    return _photos.count;
}

- (NSInteger)maxPhotoIndex {
    return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    if (photoIndex < _photos.count) {
        return [_photos objectAtIndex:photoIndex];
    } else {
        return nil;
    }
}
@end
