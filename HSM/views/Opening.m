//
//  Opening.m
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "Opening.h"

@implementation Opening

#pragma mark -
#pragma mark ViewControllers Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Controller Methods

- (void) setConfigurations
{
    [super setConfigurations];
    
    /*
    imgSponsors         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_start_sponsors.png"]];
    
    CGRect rectImg      = CGRectMake(ZERO, ZERO, WINDOW_WIDTH, WINDOW_HEIGHT);
    [imgSponsors setFrame:rectImg];
    [[self view] setBackgroundColor:[UIColor blackColor]];
    //[imgSponsors setContentMode:UIViewContentModeCenter];
    
    [[self view] addSubview:imgSponsors];
    
    [self animateStart];*/
    
    [adManager addAdTo:self.view type:kAdSuperstitial];
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[delegate window] setRootViewController:[delegate openingWithoutAnimation]];
    });
}

#pragma mark -
#pragma mark Methods

- (void)animateStart
{
    //..
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self animateEnd];
    });
}
- (void) animateEnd
{
    [[delegate window] setRootViewController:[delegate openingWithoutAnimation]];
}

@end
