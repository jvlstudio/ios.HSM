//
//  HSMAdBannerExpand.m
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSMAdBannerExpand.h"

@implementation HSMAdBannerExpand

@synthesize isExpanded;
@synthesize imageURLExpanded;
@synthesize imageExpanded;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    isExpanded = NO;
    return self;
}

#pragma mark -
#pragma mark Methods

- (void) performAd:(UIButton*)sender
{
    [super performAd:sender];
    
    if (isExpanded) {
        NSURL *adURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@", AD_URL, hsmAdId]];
        [[UIApplication sharedApplication] openURL:adURL];
        [self performReduce];
    }
    else {
        [self performExpand];
    }
}
- (void) performExpand
{
    [image setHidden:YES];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.frame;
        rect.origin.y -= (HEIGHT_EXPANDED-HEIGHT_REDUCED);
        rect.size.height = HEIGHT_EXPANDED;
        [self setFrame:rect];
    } completion:^(BOOL finished) {
        isExpanded = YES;
        NSLog(@"%f", image.frame.size.height);
    }];
}
- (void) performReduce
{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.frame;
        rect.origin.y += (HEIGHT_EXPANDED-HEIGHT_REDUCED);
        rect.size.height = HEIGHT_REDUCED;
        [self setFrame:rect];
    } completion:^(BOOL finished) {
        isExpanded = NO;
        [image setHidden:NO];
    }];
}

@end
