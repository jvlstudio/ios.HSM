//
//  Agenda.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Agenda.h"
#import "AgendaCell.h"
#import "AgendaBreakCell.h"
#import "AgendaShowCell.h"

#import "EventManager.h"

#import "PanelistSingle.h"

#define CELL_HEIGHT             95.0
#define CELL_BREAK_HEIGHT       43.0

#define CELL_IDENTIFIER         @"agendaCell"
#define CELL_BREAK_IDENTIFIER   @"agendaBreakCell"
#define CELL_SHOW_IDENTIFIER    @"agendaShowCell"
#define CELL_BG                 @"hsm_agenda_cell.png"
#define CELL_BG_2               @"hsm_agenda_cell_2.png"
#define CELL_BG_3               @"hsm_agenda_cell2.png"

#define BUT_DAY1_OFF            @"hsm_agenda_bt_day1.png"
#define BUT_DAY2_OFF            @"hsm_agenda_bt_day2.png"
#define BUT_DAY3_OFF            @"hsm_agenda_bt_day3.png"
#define BUT_DAY1_ON             @"hsm_agenda_bt_day1_on.png"
#define BUT_DAY2_ON             @"hsm_agenda_bt_day2_on.png"
#define BUT_DAY3_ON             @"hsm_agenda_bt_day3_on.png"

@interface Agenda ()
- (void) deselectButtons;
@end

@implementation Agenda
{
    FRTools *tools;
    EventManager *manager;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    //[self setTitle:[NSString stringWithFormat:@"Agenda: %@", [[self dictionary] objectForKey:KEY_NAME]]];
    [self setTitle:@"Agenda"];
    
    // ...
    tools       = [[FRTools alloc] initWithTools];
    manager     = [[EventManager alloc] initWithEvent:[self dictionary]];
    
    // data ..
    // ...
    // agenda init with an array with all event's days (dictionaries)
    // we have to split'em in X arraies, where X is the total number
    agendaDays  = [manager agenda];
    // scheduleDays: array with the "tableData"'s
    scheduleDays= [NSMutableArray array];
    for (NSDictionary *agendaObject in agendaDays)
    {
        [scheduleDays addObject:[agendaObject objectForKey:KEY_SCHEDULE]];
    }
    // finally, we set the current
    // array for table (the first) ..
    // ...
    tableData   = [scheduleDays objectAtIndex:ZERO];
    
    [table setTableHeaderView:tableHeader];
    
    // ad..
    Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    [ad correctRectOfView:table];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [table reloadData];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressDay1:(id)sender
{
    [self deselectButtons];
    [imgButDay1 setImage:[UIImage imageNamed:BUT_DAY1_ON]];
    tableData = [scheduleDays objectAtIndex:0];
    [table reloadData];
}
- (IBAction) pressDay2:(id)sender
{
    [self deselectButtons];
    [imgButDay2 setImage:[UIImage imageNamed:BUT_DAY2_ON]];
    tableData = [scheduleDays objectAtIndex:1];
    [table reloadData];
}
- (IBAction) pressDay3:(id)sender
{
    [self deselectButtons];
    [imgButDay3 setImage:[UIImage imageNamed:BUT_DAY3_ON]];
    tableData = [scheduleDays objectAtIndex:2];
    [table reloadData];
}

#pragma mark -
#pragma mark Methods

- (void) deselectButtons
{
    [imgButDay1 setImage:[UIImage imageNamed:BUT_DAY1_OFF]];
    [imgButDay2 setImage:[UIImage imageNamed:BUT_DAY2_OFF]];
    [imgButDay3 setImage:[UIImage imageNamed:BUT_DAY3_OFF]];
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
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    if ([[dict objectForKey:KEY_TYPE] isEqualToString:KEY_TYPE_SPEECH]
    ||  [[dict objectForKey:KEY_TYPE] isEqualToString:KEY_TYPE_SHOW])
        return CELL_HEIGHT;
    else
        return CELL_BREAK_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // agenda object ..
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    // panelist object ..
    NSDictionary *pan   = [manager panelistForKey:[dict objectForKey:KEY_KEY]];
    // cell..
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    id cell             = nil;
    
    // condition..
    // agenda cell..
    // ...
    if ([[dict objectForKey:KEY_TYPE] isEqualToString:KEY_TYPE_SPEECH])
    {
        cell     = (AgendaCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
        if(!cell)
            cell = (AgendaCell*)[xib objectAtIndex:kCellAgenda];
        
        // bg
        UIImageView *imgBg;
        if ([manager isPanelistScheduled:[pan objectForKey:KEY_SLUG]])
            imgBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_BG_2]];
        else
            imgBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_BG]];
        [cell setBackgroundView:imgBg];
        
        // hour
        NSArray *hours      = [tools explode:[dict objectForKey:KEY_HOUR] bySeparator:@" às "];
        
        if ([[dict objectForKey:KEY_SUBTYPE] isEqualToString:KEY_SHOWONLY])
            [[cell labText] setText:[dict objectForKey:KEY_KEY]];
        else
            [[cell labText] setText:[pan objectForKey:KEY_NAME]];
        
        NSString *strImg = [NSString stringWithFormat:@"p_%@_large.png", [pan objectForKey:KEY_SLUG]];
        [[cell imgPicture] setImage:[UIImage imageNamed:strImg]];
        [[cell labSubText] setText:[dict objectForKey:KEY_LABEL]];
        [[cell labHourInit] setText:[hours objectAtIndex:0]];
        [[cell labHourFinal] setText:[hours objectAtIndex:1]];
        
        [[cell labText] alignBottom];
        [[cell labSubText] alignTop];
    }
    // agenda show cell..
    // ...
    else if ([[dict objectForKey:KEY_TYPE] isEqualToString:KEY_TYPE_SHOW])
    {
        cell     = (AgendaShowCell*)[tableView dequeueReusableCellWithIdentifier:CELL_SHOW_IDENTIFIER];
        if(!cell)
            cell = (AgendaShowCell*)[xib objectAtIndex:kCellAgendaShow];
        
        [[cell labSubText] setTextColor:[UIColor whiteColor]];
        
        // bg
        UIImageView *imgBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_BG_3]];
        [cell setBackgroundView:imgBg];
        
        // hour
        NSArray *hours      = [tools explode:[dict objectForKey:KEY_HOUR] bySeparator:@" às "];
        
        [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
        
        if (![[dict objectForKey:KEY_SUBLABEL] isEqualToString:KEY_EMPTY])
        {
            [[cell labSubText] setText:[dict objectForKey:KEY_SUBLABEL]];
            //[[cell labSubText] alignTop];
        }
        
        [[cell labHourInit] setText:[hours objectAtIndex:0]];
        if ([hours count] > 1)
            [[cell labHourFinal] setText:[hours objectAtIndex:1]];
        else
            [[cell labHourFinal] setText:KEY_EMPTY];
        
        [[cell labText] alignBottom];
    }
    // agenda break cell..
    // ...
    else {
        cell     = (AgendaBreakCell *)[tableView dequeueReusableCellWithIdentifier:CELL_BREAK_IDENTIFIER];
        if(!cell)
            cell = (AgendaBreakCell*)[xib objectAtIndex:kCellAgendaBreak];
        
        // hour
        NSArray *hours      = [tools explode:[dict objectForKey:KEY_HOUR] bySeparator:@" às "];
        NSString *strImg = [NSString stringWithFormat:@"hsm_agenda_id_%@.png", [dict objectForKey:KEY_KEY]];
        
        // ..
        [[cell imgIcon] setImage:[UIImage imageNamed:strImg]];
        [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
        [[cell labHourInit] setText:[hours objectAtIndex:0]];
        [[cell labHourFinal] setText:[hours objectAtIndex:1]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // agenda object ..
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    // panelist object ..
    NSDictionary *pan   = [manager panelistForKey:[dict objectForKey:KEY_KEY]];
    if ([[dict objectForKey:KEY_TYPE] isEqualToString:KEY_TYPE_SPEECH]
    && ![[dict objectForKey:KEY_SUBTYPE] isEqualToString:KEY_SHOWONLY])
    {
        PanelistSingle *vc = [[PanelistSingle alloc] initWithNibName:NIB_PANELIST_SINGLE andDictionary:pan];
        [[self navigationController] pushViewController:vc animated:YES];
    }
}

@end
