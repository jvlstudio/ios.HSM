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

@synthesize dates;

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
    
	/*
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
    tableData   = [scheduleDays objectAtIndex:ZERO];*/
	
	agendaDays   = [self array];
    if ([agendaDays count] > 0) {
        scheduleDays = [[HSMaster core] agenda:agendaDays splitedByDays:dates];
        tableData   = [scheduleDays objectAtIndex:0];
    }
    else {
        tableData = [NSArray array];
    }
	
	if ([agendaDays count] > 1) {
		[table setTableHeaderView:tableHeader];
	}
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
    if ([dates count] < 3)
        [segment removeSegmentAtIndex:2 animated:NO];
    
	int i = 0;
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	[df2 setDateFormat:@"dd/MMM"];
	for (NSString *dateString in dates) {
		NSDate *date = [df dateFromString:dateString];
		[segment setTitle:[df2 stringFromDate:date] forSegmentAtIndex:i];
		i++;
	}
	
	/*
    for (uint i=0; i<[agendaDays count]; i++) {
        NSDictionary *event = [agendaDays objectAtIndex:i];
        NSArray *text = [tools explode:[event objectForKey:KEY_LABEL] bySeparator:@"-"];
        [segment setTitle:[NSString stringWithFormat:@"%@ %@", [text objectAtIndex:0], [text objectAtIndex:1]] forSegmentAtIndex:i];
    }
	*/
    
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
    NSDictionary *pan   = [dict objectForKey:@"panelist"];
    // cell..
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    id cell             = nil;
	
	NSDateFormatter *df, *df2;
	df  = [[NSDateFormatter alloc] init];
	df2 = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	[df2 setDateFormat:@"HH:mm"];
    
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
        NSDate *dateStart = [df dateFromString:[[dict objectForKey:@"date"] objectForKey:@"start"]];
		NSDate *dateEnd	  = [df dateFromString:[[dict objectForKey:@"date"] objectForKey:@"end"]];
		NSString *hourStart = [df2 stringFromDate:dateStart];
		NSString *hourEnd = [df2 stringFromDate:dateEnd];
        
        NSString *strImg = [pan objectForKey:@"picture"];
        if(strImg)
			[[cell imgPicture] setImageWithURL:[NSURL URLWithString:strImg]];
		
		[[cell labText] setText:[dict objectForKey:@"label"]];
        [[cell labSubText] setText:[dict objectForKey:@"sublabel"]];
        [[cell labHourInit] setText:hourStart];
        [[cell labHourFinal] setText:hourEnd];
        
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
		NSDate *dateStart = [df dateFromString:[[dict objectForKey:@"date"] objectForKey:@"start"]];
		NSDate *dateEnd	  = [df dateFromString:[[dict objectForKey:@"date"] objectForKey:@"end"]];
		NSString *hourStart = [df2 stringFromDate:dateStart];
		NSString *hourEnd = [df2 stringFromDate:dateEnd];
        
        [[cell labText] setText:[dict objectForKey:@"label"]];
        
        if (![[dict objectForKey:KEY_SUBLABEL] isEqualToString:KEY_EMPTY])
        {
            [[cell labSubText] setText:[dict objectForKey:KEY_SUBLABEL]];
            //[[cell labSubText] alignTop];
        }
        
        [[cell labHourInit] setText:hourStart];
        if (hourEnd)
            [[cell labHourFinal] setText:hourEnd];
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
		NSDate *dateStart = [df dateFromString:[[dict objectForKey:@"date"] objectForKey:@"start"]];
		NSDate *dateEnd	  = [df dateFromString:[[dict objectForKey:@"date"] objectForKey:@"end"]];
		NSString *hourStart = [df2 stringFromDate:dateStart];
		NSString *hourEnd = [df2 stringFromDate:dateEnd];
		
        NSString *strImg = [NSString stringWithFormat:@"hsm_agenda_id_%@.png", [dict objectForKey:@"sublabel"]];
        
        // ..
        [[cell imgIcon] setImage:[UIImage imageNamed:strImg]];
        [[cell labText] setText:[dict objectForKey:@"label"]];
        [[cell labHourInit] setText:hourStart];
        [[cell labHourFinal] setText:hourEnd];
        [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:15.0]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // agenda object ..
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    // panelist object ..
    NSDictionary *pan   = [dict objectForKey:@"panelist"];//[manager panelistForKey:[dict objectForKey:KEY_KEY]];
    if ([[dict objectForKey:KEY_TYPE] isEqualToString:KEY_TYPE_SPEECH])
    {
        PanelistSingle *vc = [[PanelistSingle alloc] initWithNibName:NIB_PANELIST_SINGLE andDictionary:pan];
        [[self navigationController] pushViewController:vc animated:YES];
    }
}

@end
