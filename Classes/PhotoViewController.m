//
//  PhotoViewController.m
//  landscapes
//
//  Created by Evan Cordell on 8/9/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoSet.h"

@implementation PhotoViewController
@synthesize photoSet = _photoSet;

- (void) viewDidLoad {
    self.photoSource = [PhotoSet testPhotoSet];
}

- (void) dealloc {
    self.photoSet = nil;    
    [super dealloc];
}

@end
