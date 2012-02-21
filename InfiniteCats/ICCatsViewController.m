//
//  ICCatsViewController.m
//  InfiniteCats
//
//  Created by Tim Johnsen on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICCatsViewController.h"
#import "ICImageView.h"

#define IMAGE_TAG 136

@implementation ICCatsViewController

#pragma mark -
#pragma mark UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	
	return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return 160.0;
	}
	
	return 256.0;
}

#pragma mark -
#pragma mark TJTileViewController

- (int)numberOfTiles {
	return 1000;
}

- (void)configureTile:(UIView *)tile forIndex:(int)index {
	if (![tile viewWithTag:IMAGE_TAG]) {
		ICImageView *imageView = [[ICImageView alloc] initWithFrame:tile.bounds];
		[imageView setTag:IMAGE_TAG];
		[tile addSubview:imageView];
		[imageView release];
	}
	
	[(ICImageView *)[tile viewWithTag:IMAGE_TAG] setCatURL:[self urlForIndex:index]];
}

#pragma mark -
#pragma mark Custom

- (NSString *)urlForIndex:(int)index {
	int width = index % 150;
	int height = index / 150;
	
	NSString *url = [NSString stringWithFormat:@"http://placekitten.com/%d/%d", 150 + width, 150 + height];
	
	return url;
}

@end
