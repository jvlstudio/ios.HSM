//
//  HSMAdBannerHome.m
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSMAdBannerHome.h"

@implementation HSMAdBannerHome

#pragma mark -
#pragma mark Methods

- (void) performAd:(UIButton*)sender
{
    [super performAd:sender];
    
    NSURL *adURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@", AD_URL, hsmAdId]];
    [[UIApplication sharedApplication] openURL:adURL];
}

@end
