//
//  HSMAdView.m
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSMAdView.h"

@implementation HSMAdView

@synthesize hsmAdId, imageURL;
@synthesize image, button;

#pragma mark -
#pragma mark Methods

- (void) performAd:(UIButton*)sender
{
    // ad perform override wil take care of this
}

- (void) commit
{
    //[image setContentMode:UIViewContentModeCenter];
    [image setImageWithURL:[NSURL URLWithString:imageURL]];
}

@end
