//
//  ICAppDelegate.h
//  InfiniteCats
//
//  Created by Tim Johnsen on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICCatsViewController.h"

@interface ICAppDelegate : UIResponder <UIApplicationDelegate> {
	ICCatsViewController *_catsViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
