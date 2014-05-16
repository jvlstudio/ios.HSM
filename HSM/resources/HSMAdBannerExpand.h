//
//  HSMAdBannerExpand.h
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSMAdView.h"

#pragma mark - Constants

#define HEIGHT_REDUCED      45
#define HEIGHT_EXPANDED     193

#pragma mark - Interface

@interface HSMAdBannerExpand : HSMAdView
{
    BOOL isExpanded;
    NSString *imageURLExpanded;
    
    IBOutlet UIImageView *imageExpanded;
}

@property (nonatomic) BOOL isExpanded;
@property (nonatomic, strong) NSString *imageURLExpanded;

@property (nonatomic, strong) IBOutlet UIImageView *imageExpanded;

#pragma mark -
#pragma mark Methods

- (void) performExpand;
- (void) performReduce;

@end
