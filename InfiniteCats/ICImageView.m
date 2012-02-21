//
//  ICImageView.m
//  InfiniteCats
//
//  Created by Tim Johnsen on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICImageView.h"

@implementation ICImageView

@synthesize catURL = _catURL;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[_catURL release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.clipsToBounds = YES;
	}
	
	return self;
}

#pragma mark -
#pragma mark TJImageCacheDelegate

- (void)didGetImage:(UIImage *)image atURL:(NSString *)url {
	if ([url isEqualToString:self.catURL]) {
		[self setAlpha:0.0];
		[self setImage:image];
		
		[UIView beginAnimations:nil context:nil];
		[self setAlpha:1.0f];
		[UIView commitAnimations];
	}
}

#pragma mark -
#pragma mark Getters and Setters

- (void)setCatURL:(NSString *)catURL {
	if (![catURL isEqualToString:_catURL]) {
		[_catURL autorelease];
		_catURL = [catURL retain];
		
		UIImage *image = [TJImageCache imageAtURL:_catURL depth:TJImageCacheDepthInternet delegate:self];
		
		if (image) {
			[self setImage:image];
			[self setAlpha:1.0];
		} else {
			[self setAlpha:0.0];
		}
	}
}


@end
