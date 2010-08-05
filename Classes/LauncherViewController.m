//
//  LauncherViewController.m
//  landscapes
//
//  Created by Sean Clifford on 7/26/10.
//  Copyright 2010 National Park Service/NCPTT. All rights reserved.
//

#import "LauncherViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation LauncherViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		//self.title.font = [UIFont fontWithName:@"Helvetica" size: 10.0];
		self.title = @"Landscapes";
		self.navigationBarStyle = UIBarStyleBlackTranslucent;
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
	[super loadView];
	
	_launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
	_launcherView.backgroundColor = [UIColor blackColor];
	_launcherView.opaque = YES;
	//_launcherView.
	_launcherView.delegate = self;
	_launcherView.columnCount = 3;
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"Landscapes"
															 image:@"bundle://landscapes-57.png"
															   URL:@"land://data/landscapes"  canDelete:NO] autorelease],

							[[[TTLauncherItem alloc] initWithTitle:@"Inventory"
															 image:@"bundle://inventory-57.png"
															   URL:@"land://Inventory" canDelete:NO] autorelease],
							
							
							[[[TTLauncherItem alloc] initWithTitle:@"Assessments"
															 image:@"bundle://assessments-57.png"
															   URL:@"land://assessments" canDelete:NO] autorelease],

							[[[TTLauncherItem alloc] initWithTitle:@"Tasks"
															 image:@"bundle://tasks-57.png"
															   URL:@"land://data/Tasks" canDelete:NO] autorelease],							
							
							
							
							[[[TTLauncherItem alloc] initWithTitle:@"Vegetation"
															 image:@"bundle://vegetation-57.png"
															   URL:@"land://assessments/TreeViewAndInput?" canDelete:NO] autorelease],	

							[[[TTLauncherItem alloc] initWithTitle:@"Cemetery"
															 image:@"bundle://cemetery-57.png"
															   URL:@"land://Cemetery" canDelete:NO] autorelease],								
							
							
							[[[TTLauncherItem alloc] initWithTitle:@"Structures"
															 image:@"bundle://structures-57.png"
															   URL:@"land://Structures" canDelete:NO] autorelease],
							
							[[[TTLauncherItem alloc] initWithTitle:@"Wildlife"
															 image:@"bundle://wildlife-57.png"
															   URL:@"land://Wildlife" canDelete:NO] autorelease],
							
							

							

	
							


							
							[[[TTLauncherItem alloc] initWithTitle:@"Photos"
															 image:@"bundle://photos-57.png"
															   URL:@"land://Photos" canDelete:NO] autorelease],						
							
							
							


						

							nil],

						   [NSArray arrayWithObjects:
						
							
							[[[TTLauncherItem alloc] initWithTitle:@"Maps"
															 image:@"bundle://maps-57.png"
															   URL:@"land://Maps" canDelete:NO] autorelease],								
							
							
							[[[TTLauncherItem alloc] initWithTitle:@"Settings"
															 image:@"bundle://settings-57.png"
															   URL:@"land://data/Settings" canDelete:NO] autorelease],								

							[[[TTLauncherItem alloc] initWithTitle:@"About NCPTT"
															 image:@"bundle://ncptt-57.png"
															   URL:@"land://data/About" canDelete:NO] autorelease],	
							

							nil],
						   nil
						   ];
	[self.view addSubview:_launcherView];
	
	TTLauncherItem* item = [_launcherView itemWithURL:@"land://data/assessments"];
	item.badgeNumber = 2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	TTNavigator *navigator = [TTNavigator navigator];
	
    [navigator openURLAction:[TTURLAction actionWithURLPath:item.URL]];
	
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end

