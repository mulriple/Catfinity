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
#define CELL_HEIGHT ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 160.0 : 256.0)

#define TOTAL_ROWS 1000
#define TOTAL_TILES ([self tilesPerRow] * TOTAL_ROWS)

@implementation ICCatsViewController

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[[self tableView] setShowsVerticalScrollIndicator:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	
	return YES;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	// Magical infinite scrolling™
	
	const CGFloat center = (TOTAL_ROWS / 2) * CELL_HEIGHT;
	const  CGFloat pageSize = (TOTAL_ROWS / 4) * CELL_HEIGHT;
	
	CGFloat y = scrollView.contentOffset.y;
	
	while (y > center + pageSize) {
		y -= pageSize;
	}
	
	while (y < center - pageSize) {
		y += pageSize;
	}
	
	[scrollView setContentOffset:CGPointMake(0.0, y)];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return CELL_HEIGHT;
}

#pragma mark -
#pragma mark TJTileViewController

- (int)numberOfTiles {
	return TOTAL_TILES;
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
	
	index %= (TOTAL_TILES / 4);
	
	int width = index % 150;
	int height = index / 150;
	
	NSString *url = [NSString stringWithFormat:@"http://placekitten.com/%d/%d", 150 + width, 150 + height];
	
	return url;
}

@end
