//
//  ICAppDelegate.m
//  InfiniteCats
//
//  Created by Tim Johnsen on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICAppDelegate.h"

@implementation ICAppDelegate

@synthesize window = _window;

- (void)dealloc {
	[_window release];
	[_catsViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
	_catsViewController = [[ICCatsViewController alloc] init];
	[self.window addSubview:_catsViewController.view];
	
    return YES;
}

@end
