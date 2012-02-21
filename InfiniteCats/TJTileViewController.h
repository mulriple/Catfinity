//
//  TJTileViewController.h
//  ConVerge
//
//  Created by Tim Johnsen on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJTileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

- (int)numberOfTiles;
- (void)configureTile:(UIView *)tile forIndex:(int)index;

- (int)tilesPerRow;

- (void)tappedTile:(UIView *)tile atIndex:(int)index;
- (void)longPressedTile:(UIView *)tile atIndex:(int)index;

@end
