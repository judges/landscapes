//
//  landscapesAppDelegate.h
//  landscapes
//
//  Created by Sean Clifford on 7/26/10.
//  Copyright National Park Service/NCPTT 2010. All rights reserved.
//


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#import "LauncherViewController.h"
//#import "LandscapesTableViewController.h"
#import "AssessmentTableViewController.h"
#import "AssessmentTreeViewAndInputController.h"
#import "AssessmentTreeCRViewController.h"
#import "PhotoViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
  NSManagedObjectModel*         _managedObjectModel;
  NSManagedObjectContext*       _managedObjectContext;
  NSPersistentStoreCoordinator* _persistentStoreCoordinator;

  // App State
  BOOL                          _modelCreated;
  BOOL                          _resetModel;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly)         NSString*               applicationDocumentsDirectory;

@end

