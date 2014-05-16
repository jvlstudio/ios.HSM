//
//  Home.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Home.h"

#import "Events.h"
#import "EventSingle.h"
#import "Books.h"
#import "Magazines.h"

#import "HSMAdBannerExpand.h"

@interface Home ()
- (void) setDisplay;
@end

@implementation Home

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Controller Methods

- (void) setConfigurations
{
    [super setConfigurations];
    
    // ...
    [self setTitle:@"HSM"];
    UIImageView *imgLogo    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_logo.png"]];
    [[self navigationItem] setTitleView:imgLogo];
    
    // ...
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
    
    [scrDisplay addSubview:butExpo];
    
    // ...
    [pageControl setNumberOfPages:0];
    [tools setCanShowErrorAlerts:NO];
	[tools requestUpdateFrom:URL_ADS success:^{
		// ...
		NSDictionary *data = [[tools JSONData] objectForKey:KEY_DATA];
        [tools propertyListWrite:data forFileName:PLIST_ADS];
        [self setDisplay];
	} fail:^{
		// ...
	}];
}
- (void) setDisplay
{
    NSInteger n = ([adManager hasAdWithCategory:kAdBannerHome] ? 1 : 0);
    [pageControl setNumberOfPages:1+n];
    [pageControl setCurrentPage:0];
    [pageControl setTintColor:COLOR_TITLE];
    
    NSInteger w = ([adManager hasAdWithCategory:kAdBannerHome] ? WINDOW_WIDTH : 0);
    [scrDisplay setContentSize:CGSizeMake(WINDOW_WIDTH+w, 200)];
    
    // ...
    [adManager addAdTo:scr type:kAdBannerExpand];
    [adManager addAdTo:scrDisplay type:kAdBannerHome];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressExpo:(id)sender
{
    //NSArray *plist      = [tools propertyListRead:PLIST_EVENTS];
    //NSDictionary *dict  = [plist objectAtIndex:0];
    
    Events *vc = [[Events alloc] initWithNibName:NIB_EVENTS bundle:nil];
    UINavigationController* n = [[UINavigationController alloc] initWithRootViewController:vc];
    //EventSingle *vc = [[EventSingle alloc] initWithNibName:NIB_EVENT_SINGLE andDictionary:dict];
    //[[self navigationController] pushViewController:vc animated:YES];
    [[self revealSideViewController] replaceCentralViewControllerWithNewController:n animated:YES animationDirection:PPRevealSideDirectionLeft completion:nil];
}
- (IBAction) pressEducation:(id)sender
{
    [tools dialogWithMessage:@"Este conteúdo estará disponível em breve." cancelButton:@"OK" title:@"Conteúdo Indisponível"];
}
- (IBAction) pressTV:(id)sender
{
    NSString *strURL = @"http://www.youtube.com/watch?v=ZHolmn4LBzg";
    NSURL *url = [ [ NSURL alloc ] initWithString: strURL ];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction) pressIssues:(id)sender
{
    //[tools dialogWithMessage:@"Este conteúdo estará disponível em breve." cancelButton:@"OK" title:@"Conteúdo Indisponível"];
    
    Magazines *vc = [[Magazines alloc] initWithNibName:NIB_MAGAZINES bundle:nil];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self revealSideViewController] replaceCentralViewControllerWithNewController:n animated:YES animationDirection:PPRevealSideDirectionLeft completion:nil];
}
- (IBAction) pressBooks:(id)sender
{
    Books *vc = [[Books alloc] initWithNibName:NIB_BOOKS bundle:nil];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self revealSideViewController] replaceCentralViewControllerWithNewController:n animated:YES animationDirection:PPRevealSideDirectionLeft completion:nil];
}

#pragma mark -
#pragma mark ScrollView Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == scrDisplay) {
        float position = scrollView.contentOffset.x/WINDOW_WIDTH;
        [pageControl setCurrentPage:position];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == scrDisplay) {
        float position = scrollView.contentOffset.x/WINDOW_WIDTH;
        [pageControl setCurrentPage:position];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UIView *subv in [[self view] subviews]) {
        if ([subv isKindOfClass:[HSMAdBannerExpand class]]) {
            HSMAdBannerExpand *ban = (HSMAdBannerExpand*)subv;
            if ([ban isExpanded]) {
                [ban performReduce];
            }
        }
    }
}

@end
