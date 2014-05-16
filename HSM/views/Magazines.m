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
    
    [[cell labTitle] setText:[dict objectForKey:KEY_TITLE]];
    [[cell labSlug] setText:[dict objectForKey:KEY_SLUG]];
    [[cell image] setImage:[UIImage imageNamed:[dict objectForKey:KEY_IMAGE]]];
    
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