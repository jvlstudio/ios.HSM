//
//  PassEnd.m
//  HSM
//
//  Created by Felipe Ricieri on 07/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassEnd.h"
#import "Home.h"

@interface PassEnd ()

@end

@implementation PassEnd

- (void)viewDidLoad
{
    [super viewDidLoadWithNothing];
    [self setTitle:@"Obrigado"];
    
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressBt:(id)sender
{
    Home *vc = [[Home alloc] initWithNibName:NIB_HOME bundle:nil];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self revealSideViewController] replaceCentralViewControllerWithNewController:n animated:YES animationDirection:PPRevealSideDirectionLeft completion:nil];
}

@end
