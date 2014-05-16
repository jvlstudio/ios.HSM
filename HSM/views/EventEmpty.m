//
//  EventEmpty.m
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "EventEmpty.h"

@implementation EventEmpty

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    
    [tvDescription setText:[[self dictionary] objectForKey:KEY_MORE_INFO]];
    
    CGRect rect = tvDescription.frame;
    //rect.origin.y += 64;
    //rect.size.height -= 64;
    [tvDescription setFrame:rect];
}

@end
