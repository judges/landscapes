//
//  VegetationVC.h
//  landscapes
//
//  Created by Sean Clifford on 8/5/10.
//  Copyright 2010 National Park Service/NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface VegetationVC : TTViewController <TTLauncherViewDelegate> {
	TTLauncherView* _vegetationView;
}

@end