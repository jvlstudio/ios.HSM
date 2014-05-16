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
#import "AgendaButtonDay.h"

#import "EventManager.h"

#import "PanelistSingle.h"

#define CELL_HEIGHT             95.0
#define CELL_BREAK_HEIGHT       43.0

#define CELL_IDENTIFIER         @"agendaCell"
#define CELL_BREAK_IDENTIFIER   @"agendaBreakCell"
#define CELL_SHOW_IDENTIFIER    @"agendaShowCell"
#define CELL_BG                 @"hsm_v5_agenda_cell_speech.png"
#define CELL_BG_2               @"hsm_v5_agenda_cell_speech_sel.png"
#define CELL_BG_3               @"hsm_v5_agenda_cell.png"

#pragma mark - Interface

@interface Agenda ()
- (void) manageButtons;
@end

#pragma mark - Implementation

@implementation Agenda
{
    EventManager *manager;
}

#pragma mark -
#pragma mark Controller Methods

- (void) viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [table reloadData];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    //[self setTitle:[NSString stringWithFormat:@"Agenda: %@", [[self dictionary] objectForKey:KEY_NAME]]];
    [self setTitle:@"Agenda"];
    
    // ...
    tools       = [[FRTools alloc] initWithTools];
    manager     = [[EventManager alloc] initWithEvent:[self dictionary]];
    
    CGRect rect = table.frame;
    rect.size.height -= IPHONE5_COEF;
    [table setFrame:rect];
    
    // data ..
    // ...
    // agenda init with an array with all event's days (dictionaries)
    // we have to split'em in X arraies, where X is the total number
    agendaDays  = [manager agenda];
    // scheduleDays: array with the "tableData"'s
    scheduleDays= [NSMutableArray array];
    for (NSDictionary *agendaObject in agendaDays){
        [scheduleDays addObject:[agendaObject objectForKey:KEY_SCHEDULE]];
    }
    // finally, we set the current
    // array for table (the first) ..
    // ...
    tableData   = [scheduleDays objectAtIndex:ZERO];
    
    [table setTableHeaderView:tableHeader];
    [self manageButtons];
    
    // ad..
    //Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    //[ad correctRectOfView:table];
    if ([adManager hasAdWithCategory:kAdBannerFooter])
        [adManager addAdTo:table type:kAdBannerFooter];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) segmentChanged:(UISegmentedControl*)sender
{
    tableData = [scheduleDays objectAtIndex:sender.selectedSegmentIndex];
    [table reloadData];
}

#pragma mark -
#pragma mark Private Methods

- (void) manageButtons
{
    if ([agendaDays count] < 3)
        [segment removeSegmentAtIndex:2 animated:NO];
    
    for (uint i=0; i<[agendaDays count]; i++) {
        NSDictionary *event = [agendaDays objectAtIndex:i];
        NSArray *text = [tools explode:[event objectForKey:KEY_LABEL] bySeparator:@"-"];
        [segment setTitle:[NSString stringWithFormat:@"%@ %@", [text objectAtIndex:0], [text objectAtIndex:1]] forSegmentAtIndex:i];
    }
    
    [segment setSelectedSegmentIndex:0];
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
        
        NSLog(@"%@", strImg);
        
        [[cell labText] alignBottom];
        [[cell labSubText] alignTop];
        
        [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:15.0]];
        //[[cell labSubText] setFont:[UIFont fontWithName:FONT_REGULAR size:12.0]];
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
        [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:15.0]];
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
        [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:15.0]];
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
