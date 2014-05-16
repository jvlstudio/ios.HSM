//
//  EventMultiple.m
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "EventMultiple.h"
#import "EventMultipleCell.h"

#import "EventSingle.h"
#import "EventEmpty.h"

@implementation EventMultiple

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Default Methods

- (void)setConfigurations
{
    [super setConfigurations];
    
    tableData   = [self array];
    //[table setTableHeaderView:[self edge]];
    
    // ad..
    //Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    //[ad correctRectOfView:table];
    if ([adManager hasAdWithCategory:kAdBannerFooter])
        [adManager addAdTo:table type:kAdBannerFooter];
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    EventMultipleCell *cell = (EventMultipleCell*)[xib objectAtIndex:kCellEventMultiple];
    
    if ([[dict objectForKey:KEY_LABEL] isEqualToString:KEY_EMPTY])
    {
        NSString *strLabel = [NSString stringWithFormat:@"Auditório %i", (indexPath.row+1)];
        [[cell labText] setText:strLabel];
    }
    else
        [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
    
    [[cell labSubtext] setText:[dict objectForKey:KEY_SUBLABEL]];
    [[cell labSubtext] setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:[indexPath row]];
    if ([[dict objectForKey:KEY_SLUG] isEqualToString:@"bdw"])
    {
        NSArray *events = [tools propertyListRead:PLIST_EVENTS];
        NSDictionary *bdw   = [events objectAtIndex:1];
        EventSingle *vc = [[EventSingle alloc] initWithNibName:NIB_EVENT_SINGLE andDictionary:bdw];
        [[self navigationController] pushViewController:vc animated:YES];
    }
    else {
        
        if ([dict objectForKey:KEY_MORE_INFO])
        {
            EventEmpty *vc = [[EventEmpty alloc] initWithNibName:NIB_EVENT_EMPTY andDictionary:dict];
            [vc setTitle:[NSString stringWithFormat:@"%@", [dict objectForKey:KEY_SUBLABEL]]];
            [[self navigationController] pushViewController:vc animated:YES];
        }
        else {
            [tools promptWithMessage:@"Você será redirecionado para o cronograma de palestras deste auditório. Deseja continuar?" competitionYes:^{
                NSURL *url = [ [ NSURL alloc ] initWithString: [dict objectForKey:KEY_LINK] ];
                [[UIApplication sharedApplication] openURL:url];
            } competitionNo:^{
                // ...
            }];
        }
    }
}

@end
