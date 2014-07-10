//
//  UIPageControlCustomized.m
//  T-APL
//
//  Created by Felipe Ricieri on 20/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "UIPageControlCustomized.h"

/* interface */

@interface UIPageControlCustomized ()
- (void) updateDots;
@end

/* implementation */

@implementation UIPageControlCustomized

#pragma mark -
#pragma mark Super Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self updateDots];
    }
    return self;
}

- (void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    [self updateDots];
}

#pragma mark -
#pragma mark Custom Methods

- (void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage) dot.image = activeImage;
        else dot.image = inactiveImage;
    }
}

- (void) configureBullets:(NSString*) actived : (NSString*) disactived
{
    activeImage = [UIImage imageNamed:actived];
    inactiveImage = [UIImage imageNamed:disactived];
}

@end
