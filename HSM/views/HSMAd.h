//
//  HSMAd.h
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FRTools.h"
#import "AppDelegate.h"

#pragma mark - Constants

#define AD_RESOURCES    @"HSMAdResources"
#define AD_KEYS         @[@"superstitial", @"banner_footer", @"banner_home", @"banner_expand", @"banner_menu"]

#pragma mark - Types

typedef enum HSMAdResource : NSInteger
{
    kAdSuperstitial     = 0,
    kAdBannerFooter     = 1,
    kAdBannerHome       = 2,
    kAdBannerExpand     = 3,
    kAdBannerMenu       = 4
}
HSMAdResource;

#pragma mark - Interface

@interface HSMAd : NSObject
{
    NSArray *adsList;
    NSDictionary *profile;
}

#pragma mark -
#pragma mark Init Methods

- (id) initWithManager;
- (id) initWithProfile:(NSDictionary*) dProfile;

#pragma mark -
#pragma mark Methods

- (void) hit:(NSString*) adId;
- (void) addAdTo:(UIView*) view type:(HSMAdResource) type;
- (BOOL) hasAdWithCategory:(HSMAdResource) type;
- (NSDictionary*) adForType:(HSMAdResource) type;

- (void) didScrollToReduce;

@end
