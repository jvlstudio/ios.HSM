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

@interface Home ()

@end

@implementation Home
{
    FRTools *tools;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    
    // ...
    [self setTitle:@"HSM"];
    UIImageView *imgLogo    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_logo.png"]];
    [[self navigationItem] setTitleView:imgLogo];
    
    // ...
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
    
    tools   = [[FRTools alloc] initWithTools];
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
    [tools dialogWithMessage:@"Este conteúdo estará disponível em breve." cancelButton:@"OK" title:@"Conteúdo Indisponível"];
}
- (IBAction) pressBooks:(id)sender
{
    Books *vc = [[Books alloc] initWithNibName:NIB_BOOKS bundle:nil];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self revealSideViewController] replaceCentralViewControllerWithNewController:n animated:YES animationDirection:PPRevealSideDirectionLeft completion:nil];
}

@end
