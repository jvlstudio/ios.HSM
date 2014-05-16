//
//  HSMAd.m
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSMAd.h"

#import "HSMAdSuperstitial.h"
#import "HSMAdBannerFooter.h"
#import "HSMAdBannerHome.h"
#import "HSMAdBannerExpand.h"
#import "HSMAdBannerMenu.h"

@interface HSMAd ()

@end

@implementation HSMAd
{
    FRTools *tools;
    AppDelegate *delegate;
}

#pragma mark -
#pragma mark Init Methods

- (id) initWithManager
{
    self = [super init];
    tools   = [[FRTools alloc] initWithTools];
    delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    adsList = [tools propertyListRead:PLIST_ADS];
    return self;
}
- (id) initWithProfile:(NSDictionary*) dProfile
{
    self = [super init];
    profile = dProfile;
    tools   = [[FRTools alloc] initWithTools];
    delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    adsList = [tools propertyListRead:PLIST_ADS];
    return self;
}

#pragma mark -
#pragma mark Methods

- (void) hit:(NSString*) adId
{
    // get user..
    //NSDictionary *user  = [tools propertyListRead:PLIST_MYCONTACT];
    //NSString *userId    = [user objectForKey:KEY_PHONE];
    //double latitude     = userLocation.coordinate.latitude;
    //double longitude    = userLocation.coordinate.longitude;
    //NSString *latlng    = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
    
    NSString *str = [NSString stringWithFormat:URL_ADS_RECEIVE, adId];
    
    //[tools setCanShowErrorAlerts:NO];
    [tools requestUpdateFrom:str success:^{
        NSLog(@"- [ADS]: hit the ad: %@", adId);
    } fail:^{
        // do not hit with no connection
        //[self hit:adId];
    }];
}
- (void) addAdTo:(UIView*) view type:(HSMAdResource) type
{
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:AD_RESOURCES owner:nil options:nil];
    NSDictionary *ad    = [self adForType:type];
    HSMAdView* adView = nil;
    
    // config..
    switch (type)
    {
        case kAdSuperstitial:
        {
            adView = (HSMAdSuperstitial*)[xib objectAtIndex:type];
        }
            break;
        case kAdBannerFooter:
        {
            adView = (HSMAdBannerFooter*)[xib objectAtIndex:type];
            
        }
            break;
        case kAdBannerExpand:
        {
            HSMAdBannerExpand *adExpand = (HSMAdBannerExpand*)adView;
            adExpand = (HSMAdBannerExpand*)[xib objectAtIndex:type];
            [adExpand setImageURLExpanded:[NSString stringWithFormat:@"%@/ads/%@", URL_ADS_UPLOADS, [ad objectForKey:KEY_IMAGE_EXP]]];
            [[adExpand imageExpanded] setImageWithURL:[NSURL URLWithString:[adExpand imageURLExpanded]]];
            
            adView = adExpand;
        }
            break;
        case kAdBannerHome:
        {
            adView = (HSMAdBannerHome*)[xib objectAtIndex:type];
        }
            break;
        case kAdBannerMenu:
        {
            adView = (HSMAdBannerMenu*)[xib objectAtIndex:type];
        }
            break;
    }
    
    [adView setHsmAdId:[ad objectForKey:KEY_ID]];
    [[adView button] addTarget:adView action:@selector(performAd:) forControlEvents:UIControlEventTouchUpInside];
    [adView setImageURL:[NSString stringWithFormat:@"%@/ads/%@", URL_ADS_UPLOADS, [ad objectForKey:KEY_IMAGE]]];
    [adView commit];
    
    [self hit:[ad objectForKey:KEY_ID]];
    
    // set..
    switch (type)
    {
        case kAdSuperstitial:
        {
            CGRect rect = adView.frame;
            rect.size.height = WINDOW_HEIGHT;
            [adView setFrame:rect];
            
            CGRect rectImg = adView.image.frame;
            rectImg.size.height = WINDOW_HEIGHT;
            [[adView image] setFrame:rectImg];
            [[adView image] setContentMode:UIViewContentModeCenter];
            
            [view addSubview:adView];
        }
            break;
        case kAdBannerFooter:
        case kAdBannerExpand:
        {
            if ((WINDOW_HEIGHT - adView.frame.size.height) == view.frame.size.height) {
                // nothing..
            }
            else {
                CGRect rectView = view.frame;
                rectView.size.height -= adView.frame.size.height;
                [view setFrame:rectView];
            }
            
            CGRect rectAd = adView.frame;
            rectAd.origin.y = WINDOW_HEIGHT - rectAd.size.height;
            rectAd.origin.x = (WINDOW_WIDTH-rectAd.size.width)/2;
            [adView setFrame:rectAd];
            
            [[view superview] addSubview:adView];
        }
            break;
        case kAdBannerHome:
        {
            CGRect rectAd = adView.frame;
            rectAd.origin.x = WINDOW_WIDTH;
            [adView setFrame:rectAd];
            [view addSubview:adView];
        }
            break;
        case kAdBannerMenu:
            // ...
            break;
    }
}

#pragma mark -
#pragma mark Private Methods

- (NSDictionary*) adForType:(HSMAdResource) type
{
    NSLog(@"%@", [AD_KEYS objectAtIndex:type]);
    NSMutableArray *mutarr = [NSMutableArray array];
    for (NSDictionary *dict in adsList) {
        if ([[dict objectForKey:KEY_SUBTYPE] isEqualToString:[AD_KEYS objectAtIndex:type]]) {
            [mutarr addObject:dict];
        }
    }
    
    NSInteger randomIndex = [mutarr count] > 0 ? arc4random() % [mutarr count] : 0;
    NSLog(@"random: %i, total: %i", randomIndex, [mutarr count]);
    
    if ([mutarr count] > 0)
        return [mutarr objectAtIndex:randomIndex];
    else
        return nil;
}
- (BOOL) hasAdWithCategory:(HSMAdResource) type
{
    for (NSDictionary *dict in adsList)
        if ([[dict objectForKey:KEY_SUBTYPE] isEqualToString:[AD_KEYS objectAtIndex:type]])
            return YES;
    
    return NO;
}

- (void) didScrollToReduce
{
    
}

@end
