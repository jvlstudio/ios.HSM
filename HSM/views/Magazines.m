//
//  Magazines.m
//  HSM
//
//  Created by Felipe Ricieri on 05/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "Magazines.h"
#import "MagazineCell.h"

@implementation Magazines

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    [self setConfigurations];
}
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// read list..
	if ([tableData count] == 0) {
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.labelText = @"Carregando Edições...";
		[[HSMaster rest] magazines:^(BOOL succeed, NSDictionary *result) {
			[hud hide:YES];
			if (succeed) {
				if (result != nil) {
					NSArray *rows = [result objectForKey:@"data"];
					[tools propertyListWrite:rows forFileName:PLIST_MAGAZINES];
					tableData = rows;
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
		// update..
		[[HSMaster rest] loadInBackground:YES];
		[[HSMaster rest] magazines:^(BOOL succeed, NSDictionary *result) {
			if (succeed) {
				if (result != nil) {
					NSArray *rows = [result objectForKey:@"data"];
					[tools propertyListWrite:rows forFileName:PLIST_MAGAZINES];
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
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Revistas"];
    
    tools       = [[FRTools alloc] initWithTools];
    tableData   = [tools propertyListRead:PLIST_MAGAZINES];
	
    [table setTableHeaderView:tableHeader];
}

#pragma mark - IBActions

- (void) pressButton:(id)sender
{
    // ...
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/hsm-revista/id517676208?l=pt&ls=1&mt=8"]];
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
    return 100.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:[indexPath row]];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    MagazineCell *cell  = (MagazineCell*)[tableView dequeueReusableCellWithIdentifier:@"magazineCell"];
    
    if(!cell)
        cell = (MagazineCell*)[xib objectAtIndex:kCellMagazine];
    
    [[cell labTitle] setText:[dict objectForKey:@"name"]];
    [[cell labSlug] setText:[dict objectForKey:@"description"]];
    [[cell image] setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"picture"]]];
    
    [[cell labTitle] setFont:[UIFont fontWithName:FONT_REGULAR size:cell.labTitle.font.pointSize]];
    [[cell labTitle] alignBottom];
    [[cell labSlug] alignTop];
    
    [[cell button] addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_magazine_cell.png"]];
    [cell setBackgroundView:background];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pressButton:nil];
}

@end
