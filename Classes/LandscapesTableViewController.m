//
//  LandscapesTableViewController.m
//  landscapes
//
//  Created by Sean Clifford on 8/12/10.
//  Copyright 2010 National Park Service/NCPTT. All rights reserved.
//

#import "LandscapesTableViewController.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation LandscapesTableViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
  if (self = [super init]) {
    self.variableHeightRows = YES;

	
    self.dataSource =
      [TTListDataSource dataSourceWithObjects:
        nil,
         nil];
  }

  return self;
}


@end

