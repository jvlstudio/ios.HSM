//
//  EventMiddle.m
//  HSM
//
//  Created by Felipe Ricieri on 23/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "EventMiddle.h"
#import "EventSingle.h"
#import "EventMultiple.h"

@interface EventMiddle ()

@end

@implementation EventMiddle
{
    FRTools *tools;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setTitle:@"Auditórios"];
    
    tools   = [[FRTools alloc] initWithTools];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressBDW:(id)sender
{
    NSArray *events     = [tools propertyListRead:PLIST_EVENTS];
    NSDictionary *dict  = [events objectAtIndex:1];
    EventSingle *vc     = [[EventSingle alloc] initWithNibName:NIB_EVENT_SINGLE andDictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressMostra:(id)sender
{
    NSArray *events     = [tools propertyListRead:PLIST_EVENTS];
    NSDictionary *dict  = [events objectAtIndex:2];
    NSArray *content    = [dict objectForKey:@"agenda2"];
    EventMultiple *vc   = [[EventMultiple alloc] initWithNibName:NIB_EVENT_MULTIPLE andArray:content];
    [vc setTitle:@"Estações do Conhecimento"];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
