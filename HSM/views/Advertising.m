//
//  Advertising.m
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Advertising.h"

#define URL_AD          @"http://apps.ikomm.com.br/hsm/graph/ad.php?antcache=%i"
#define KEY_BANNER      @"banner"
#define KEY_URL         @"url"

#define TIMER_DELAY         5.0

@interface Advertising ()
- (void)changeImageAtAd:(id) sender;
@end

@implementation Advertising
{
    FRTools *tools;
    
    NSTimer *timer;
    NSArray *banners;
    NSDictionary *bannerActive;
}

@synthesize but, img;

- (id) initOnView:(UIView*) sview
{
    self = [super initWithNibName:@"Advertising" bundle:nil];
    [sview addSubview:[self view]];
    
    [[self view] setFrame:AD_RECT];
    
    return self;
}
- (void) correctRectOfView:(UIView*) sview
{
    CGRect rect = sview.frame;
    rect.size.height    -= AD_HEIGHT;
    [sview setFrame:rect];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // ..
    tools   = [[FRTools alloc] initWithTools];
    
    int r = arc4random() % 300;
    NSString *strURL = [NSString stringWithFormat:URL_AD, r];
    [tools requestUpdateFrom:strURL success:^{
        NSDictionary *dict  = [tools JSONData];
        banners    = [dict objectForKey:KEY_DATA];
        //NSLog(@"banners: %@", banners);
        
        //
        [self changeImageAtAd:nil];
        
        // timer..
        timer   = [NSTimer scheduledTimerWithTimeInterval:TIMER_DELAY target:self
                                                 selector:@selector(changeImageAtAd:)
                                                 userInfo:nil repeats:YES];
    }];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
}

- (void)changeImageAtAd:(id) sender
{
    if ([banners count]>0)
    {
        int r = arc4random() % [banners count];
        bannerActive = [banners objectAtIndex:r];
        [img setImageWithURL:[NSURL URLWithString:[bannerActive objectForKey:KEY_BANNER]]];
        //NSLog(@"%@", bannerActive);
    }
}

- (IBAction) pressAd:(id)sender
{
    if ([bannerActive count] > 0)
    {
        //NSLog(@"%@", bannerActive);
        NSString *strURL = [bannerActive objectForKey:KEY_URL];
        NSURL *url = [ [ NSURL alloc ] initWithString: strURL ];
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"empty");
    }
}

@end
