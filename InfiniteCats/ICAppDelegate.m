//
//  ICAppDelegate.m
//  InfiniteCats
//
//  Created by Tim Johnsen on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICAppDelegate.h"
#import "ICCatsViewController.h"

@implementation ICAppDelegate

@synthesize window = _window;

- (void)dealloc {
	[_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
	ICCatsViewController *catsViewController = [[ICCatsViewController alloc] init];
	[self.window addSubview:catsViewController.view];
	
    return YES;
}

@end
