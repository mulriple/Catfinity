//
//  TJTileViewController.m
//  ConVerge
//
//  Created by Tim Johnsen on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TJTileViewController.h"

#define TILE_INSET ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 4.0f : 4.0f) 
#define TILE_TAG 666

@interface TJTileViewController ()

- (void)_tappedTile:(UIGestureRecognizer *)recognizer;
- (void)_longPressedTile:(UIGestureRecognizer *)recognizer;
- (int)_indexForTile:(UIView *)tile;

@end

@implementation TJTileViewController

@synthesize tableView;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
	self.tableView = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)loadView {
	[super loadView];
	
	self.tableView = [[[UITableView alloc] init] autorelease];
	self.tableView.frame = self.view.bounds;
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	
	[self.view addSubview:self.tableView];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
	self.tableView = nil;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.tableView reloadData];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[self tableView] reloadData];
}

#pragma mark -
#pragma mark UITableViewDatasource

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return ceil((float)[self numberOfTiles] / [self tilesPerRow]);
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJTileViewControllerCell"];
	
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJTileViewControllerCell"] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	
	for (int i = 0 ; i < [self tilesPerRow] ; i++) {
		int tag = TILE_TAG + i;
		if (indexPath.row * [self tilesPerRow] + i < [self numberOfTiles]) {
			
			if (![cell viewWithTag:tag]) {
				UIView *tile = [[UIView alloc] init];
				
				[tile setTag:tag];
				[tile setBackgroundColor:[UIColor blackColor]];
				[tile setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
				
				UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tappedTile:)] autorelease];
				UILongPressGestureRecognizer *longPress = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_longPressedTile:)] autorelease];
				[tile addGestureRecognizer:tap];
				[tile addGestureRecognizer:longPress];
				
				[cell addSubview:tile];
				[tile release];
			}
			
			// Configure Tile
			[[cell viewWithTag:tag] setFrame:CGRectInset(CGRectMake((self.view.bounds.size.width / [self tilesPerRow]) * i, 0.0f, self.view.bounds.size.width / [self tilesPerRow], cell.bounds.size.height), TILE_INSET, TILE_INSET)];
			
			[[cell viewWithTag:tag] setHidden:NO];
			[self configureTile:[cell viewWithTag:tag] forIndex:indexPath.row * [self tilesPerRow] + i];
		} else {
			[[cell viewWithTag:tag] setHidden:YES];
		}
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	for (int i = 0 ; i < [self tilesPerRow] ; i++) {
		int tag = TILE_TAG + i;
		if (indexPath.row * [self tilesPerRow] + i < [self numberOfTiles]) {
			[[cell viewWithTag:tag] setFrame:CGRectInset(CGRectMake((self.view.bounds.size.width / [self tilesPerRow]) * i, 0.0f, self.view.bounds.size.width / [self tilesPerRow], cell.bounds.size.height), TILE_INSET, TILE_INSET)];
		}
	}
}

#pragma mark -
#pragma mark Private

- (void)_tappedTile:(UIGestureRecognizer *)recognizer {
	if ([recognizer state] == UIGestureRecognizerStateEnded) {
		int index = [self _indexForTile:[recognizer view]];
		if (index < [self numberOfTiles]) {
			[self tappedTile:[recognizer view] atIndex:index];
		}
	}
}

- (void)_longPressedTile:(UIGestureRecognizer *)recognizer {
	if ([recognizer state] == UIGestureRecognizerStateBegan) {
		int index = [self _indexForTile:[recognizer view]];
		if (index < [self numberOfTiles]) {
			[self longPressedTile:[recognizer view] atIndex:index];
		}
	}
}

- (int)_indexForTile:(UIView *)tile {
	int index = [self.tableView indexPathForCell:(UITableViewCell *)[tile superview]].row * [self tilesPerRow];
	index += [tile tag] - TILE_TAG;
	return index;
}

#pragma mark -
#pragma mark DataSource

- (int)numberOfTiles {
	return 40;
}

- (void)configureTile:(UIView *)tile forIndex:(int)index {
}

- (int)tilesPerRow {
	return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 2 : 3);
}

#pragma mark -
#pragma mark Delegate

- (void)tappedTile:(UIView *)tile atIndex:(int)index {
}

- (void)longPressedTile:(UIView *)tile atIndex:(int)index {
}

@end
