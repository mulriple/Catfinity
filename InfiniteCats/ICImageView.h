//
//  ICImageView.h
//  InfiniteCats
//
//  Created by Tim Johnsen on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJImageCache.h"

@interface ICImageView : UIImageView <TJImageCacheDelegate> {
	NSString *_catURL;
}

@property (nonatomic, retain) NSString *catURL;

@end
