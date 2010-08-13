//
//  LandscapesTableViewController.m
//  landscapes
//
//  Created by Sean Clifford on 8/12/10.
//  Copyright 2010 National Park Service/NCPTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "AppDelegate.h"
#import "LandscapesTableViewController.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation LandscapesTableViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
  if (self = [super init]) {
    self.variableHeightRows = YES;
	  

    /* self.dataSource =
      [TTListDataSource dataSourceWithObjects:
        [[TTTableTitleItem item] applyTitle:@"Table cell item"],
         nil];
	 	 */
  }


  return self;
}


@end

