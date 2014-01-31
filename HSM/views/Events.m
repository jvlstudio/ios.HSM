//
//  Events.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Events.h"
#import "EventCell.h"
#import "EventSingle.h"

#define CELL_HEIGHT     174.0
#define CELL_IDENTIFIER @"eventCell"

@interface Events ()

@end

@implementation Events
{
    FRTools *tools;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    [self setTitle:@"HSM ExpoManagement 13"];
    
    // table data..
    tools       = [[FRTools alloc] initWithTools];
    
    // all, but bdw13..
    NSMutableArray *marr    = [tools propertyListRead:PLIST_EVENTS];
    //[marr removeObjectAtIndex:1];
            
    tableData   = [marr copy];
    
    CGRect edgeframe    = [[self edge] frame];
    edgeframe.size.height = 80;
    [[self edge] setFrame:edgeframe];
    [table setTableHeaderView:[self edge]];
    
    // ad..
    Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    [ad correctRectOfView:table];
}

#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource Methods

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
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    EventCell *cell     = (EventCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if(!cell)
        cell = (EventCell*)[xib objectAtIndex:kCellEvents];
    
    [[cell labText] setText:[dict objectForKey:KEY_NAME]];
    [[cell labDates] setText:[dict objectForKey:KEY_DATE]];
    [[cell labLocation] setText:[dict objectForKey:KEY_LOCAL]];
    [[cell labSubtext] setText:[dict objectForKey:KEY_TINY_DESCRIPTION]];
    
    NSString *strImg    = [NSString stringWithFormat:@"events_list_%@.png", [dict objectForKey:KEY_SLUG]];
    [[cell imgCover] setImage:[UIImage imageNamed:strImg]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:[indexPath row]];
    EventSingle *vc     = [[EventSingle alloc] initWithNibName:NIB_EVENT_SINGLE andDictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
