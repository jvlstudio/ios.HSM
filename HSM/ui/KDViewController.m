//
//  KDViewController.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"
#import "KDBarButton.h"

#import "Menu.h"

@interface KDViewController ()
- (void) setHSMConfigurations;
@end

@implementation KDViewController

@synthesize adManager;
@synthesize delegate;
@synthesize tools;
@synthesize dictionary;
@synthesize array;
@synthesize edge;
@synthesize titleLabel;

#pragma mark -
#pragma mark Init Methods

- (id) initWithNibName:(NSString*) nibName andDictionary:(NSDictionary*) dict
{
    self = [super initWithNibName:nibName bundle:nil];
    dictionary  = dict;
    return self;
}
- (id) initWithNibName:(NSString*) nibName andArray:(NSArray*) arr
{
    self = [super initWithNibName:nibName bundle:nil];
    array       = arr;
    return self;
}
- (id) initWithNibName:(NSString*) nibName andArray:(NSArray*) arr andDictionary:(NSDictionary*) dict
{
    self = [super initWithNibName:nibName bundle:nil];
    array       = arr;
    dictionary  = dict;
    return self;
}

#pragma mark -
#pragma mark ViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setHSMConfigurations];
}

- (void) viewDidLoadWithMenuButton
{
    [super viewDidLoad];
    [self setHSMConfigurations];
    [self setMenuButton];
    [self setNothingOnRight];
}
- (void) viewDidLoadWithBackButton
{
    [super viewDidLoad];
    [self setHSMConfigurations];
    [self setBackButton];
    [self setNothingOnRight];
}
- (void)viewDidLoadWithCloseButton
{
    [super viewDidLoad];
    [self setHSMConfigurations];
    [self setCloseButton];
    [self setNothingOnLeft];
}
- (void) viewDidLoadWithNothing
{
    [super viewDidLoad];
    [self setHSMConfigurations];
    [self setNothingOnLeft];
    [self setNothingOnRight];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[[self navigationController] navigationBar] setBarTintColor:[UIColor colorWithRed:206.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // left (menu)
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadLeft) object:nil];
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.3];
}

- (void) setTitle:(NSString *)title
{
	[super setTitle:title];
	
	//title = [title uppercaseString];
	
	// ...
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZERO, ZERO, WINDOW_WIDTH, 30)];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    
    [[self navigationItem] setTitleView:titleLabel];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    delegate    = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    tools       = [[FRTools alloc] initWithTools];
    adManager   = [[HSMAd alloc] initWithManager];
}

#pragma mark -
#pragma mark BarButton Methods

- (void) setMenuButton
{
    UIBarButtonItem *bt = [[KDBarButton alloc] initWithMenu:@selector(pressMenuButton:) toTarget:self];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = bt;
    
    // reinit the bouncing directions (should not be done in your own implementation, this is just for the sample)
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionLeft];
}
- (void) setBackButton
{
    UIBarButtonItem *bt = [[KDBarButton alloc] initWithBack:@selector(pressBackButton:) toTarget:self];
    self.navigationItem.leftBarButtonItem = bt;
    self.navigationItem.hidesBackButton = YES;
}
- (void) setCloseButton
{
    UIBarButtonItem *bt = [[KDBarButton alloc] initWithClose:@selector(pressCloseButton:) toTarget:self];
    self.navigationItem.rightBarButtonItem = bt;
}
- (void) setScanButtonWithSelector:(SEL)select
{
    UIBarButtonItem *bt = [[KDBarButton alloc] initWithScan:select toTarget:self];
    self.navigationItem.rightBarButtonItem = bt;
}
- (void) setNothingOnLeft
{
    UIBarButtonItem *bt = [[KDBarButton alloc] initWithEmpty];
    [[self navigationItem] setLeftBarButtonItem:bt];
    self.navigationItem.hidesBackButton = YES;
}
- (void) setNothingOnRight
{
    UIBarButtonItem *bt = [[KDBarButton alloc] initWithEmpty];
    [[self navigationItem] setRightBarButtonItem:bt];
}

#pragma mark -
#pragma mark IBAction Methods

- (void) pressMenuButton:(id)sender
{
    [self showLeft];
}
- (void) pressBackButton:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void) pressCloseButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Side Menu Methods

- (void) preloadLeft
{
    Menu *c = [[Menu alloc] initWithNibName:NIB_MENU bundle:nil];
    [self.revealSideViewController preloadViewController:c
                                                 forSide:PPRevealSideDirectionLeft
                                              withOffset:SIDE_MENU_OFFSET];
    PP_RELEASE(c);
}
- (void) showLeft
{
    Menu *c = [[Menu alloc] initWithNibName:NIB_MENU bundle:nil];
    [self.revealSideViewController pushViewController:c
                                          onDirection:PPRevealSideDirectionLeft
                                           withOffset:SIDE_MENU_OFFSET
                                             animated:YES];
    PP_RELEASE(c);
}

#pragma mark -
#pragma mark Methods

- (void) setHSMConfigurations
{
    [[self view] setBackgroundColor:[UIColor clearColor]];
    
    imgBackgroundNavBar = [UIImage imageNamed:@"hsm_v5_navbar_2.png"];
    edge                = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 64)];
    
    // background...
    [[self view] setBackgroundColor:COLOR_BACKGROUND];
    [edge setBackgroundColor:[UIColor clearColor]];
    
    // navigation bar...
    [[[self navigationController] navigationBar] setTintColor:[UIColor whiteColor]];
    [[[self navigationController] navigationBar] setTranslucent:YES];
    [[[self navigationController] navigationBar] setBackgroundImage:imgBackgroundNavBar forBarMetrics:UIBarMetricsDefault];
}

@end
