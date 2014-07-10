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

#define CELL_HEIGHT     160.0
#define CELL_IDENTIFIER @"eventCell"

#pragma mark - Interface

@interface Events ()
@end

#pragma mark - Implementation

@implementation Events
{
	NSArray *events;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Controller Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Eventos"];
	
	// read list..
	events = [tools propertyListRead:PLIST_REST_EVENTS];
	if ([events count] == 0) {
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.labelText = @"Carregando Eventos...";
		[[HSMaster rest] events:^(BOOL succeed, NSDictionary *result) {
			[hud hide:YES];
			if (succeed) {
				if (result != nil) {
					NSArray *rows = [result objectForKey:@"data"];
					[tools propertyListWrite:rows forFileName:PLIST_REST_EVENTS];
					tableData = [[HSMaster core] nextEvents:rows];
					[table reloadData];
				}
				else {
					[tools dialogWithMessage:@"Não foi possível carregar o conteúdo" title:@"Atençao"];
				}
			}
			else {
				[tools dialogWithMessage:[result objectForKey:@"message"] title:@"Atenção"];
			}
		}];
	}
	else {
		tableData   = [[HSMaster core] nextEvents:events];
		// update..
		[[HSMaster rest] loadInBackground:YES];
		[[HSMaster rest] events:^(BOOL succeed, NSDictionary *result) {
			if (succeed) {
				if (result != nil) {
					NSArray *rows = [result objectForKey:@"data"];
					[tools propertyListWrite:rows forFileName:PLIST_REST_EVENTS];
				}
				else {
					[tools dialogWithMessage:@"Não foi possível carregar o conteúdo" title:@"Atençao"];
				}
			}
			else {
				[tools dialogWithMessage:[result objectForKey:@"message"] title:@"Atenção"];
			}
		}];
	}
    
    [table setTableHeaderView:tableHeader];
    
    CGRect rect = table.frame;
    rect.size.height -= IPHONE5_COEF;
    [table setFrame:rect];
    
    // ad..
    //Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    //[ad correctRectOfView:table];
    
    if ([adManager hasAdWithCategory:kAdBannerFooter])
        [adManager addAdTo:table type:kAdBannerFooter];
}

/*
- (NSArray*) nextEvents
{
    NSArray *events = [tools propertyListRead:PLIST_EVENTS];
    NSMutableArray *selected = [NSMutableArray array];
    
    for (NSDictionary *dict in events)
        if ([[dict objectForKey:KEY_DID_HAPPEN] isEqualToString:KEY_NO])
            [selected addObject:dict];
    
    return [selected copy];
}
- (NSArray*) prevEvents
{
    NSArray *events = [tools propertyListRead:PLIST_EVENTS];
    NSMutableArray *selected = [NSMutableArray array];
    
    for (NSDictionary *dict in events)
        if ([[dict objectForKey:KEY_DID_HAPPEN] isEqualToString:KEY_YES])
            [selected addObject:dict];
    
    return [selected copy];
}
*/

#pragma mark -
#pragma mark IBActions

- (IBAction) changedValue:(UISegmentedControl*)sender
{
    if (segment.selectedSegmentIndex == 0)
        tableData = [[HSMaster core] nextEvents:events];
    else
        tableData = [[HSMaster core] previousEvents:events];
    
    [table reloadData];
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
    NSDictionary *dict  = [[tableData objectAtIndex:indexPath.row] objectForKey:@"info"];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    EventCell *cell     = (EventCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if(!cell)
        cell = (EventCell*)[xib objectAtIndex:kCellEvents];
    
    [[cell labText] setText:[dict objectForKey:@"name"]];
    [[cell labDates] setText:[dict objectForKey:@"date_pretty"]];
    [[cell labLocation] setText:[dict objectForKey:@"locale"]];
    [[cell labSubtext] setText:[dict objectForKey:@"tiny_description"]];
    
    [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:cell.labText.font.pointSize]];
    //[[cell labSubtext] setFont:[UIFont fontWithName:FONT_REGULAR size:cell.labSubtext.font.pointSize]];
    [[cell labLocation] setFont:[UIFont fontWithName:FONT_REGULAR size:cell.labLocation.font.pointSize]];
    [[cell labDates] setFont:[UIFont fontWithName:FONT_REGULAR size:cell.labDates.font.pointSize]];
    
    NSString *strImg    = [[dict objectForKey:@"images"] objectForKey:@"list"];
    [[cell imgCover] setImageWithURL:[NSURL URLWithString:strImg]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:[indexPath row]];
    EventSingle *vc     = [[EventSingle alloc] initWithNibName:NIB_EVENT_SINGLE andDictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
