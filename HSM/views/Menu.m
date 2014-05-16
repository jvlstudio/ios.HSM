//
//  Menu.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Menu.h"
#import "MenuCell.h"

#import "Home.h"
#import "Events.h"
#import "Books.h"
#import "Magazines.h"
#import "Network.h"

#import "HSMAd.h"
#import "HSMAdBannerMenu.h"

#define CELL_HEIGHT     50.0
#define CELL_IDENTIFIER @"menuCell"

@interface Menu ()

@end

@implementation Menu
{
    FRTools *tools;
    AppDelegate *delegate;
    HSMAd *adManager;
}

@synthesize table;
@synthesize tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // table data..
    tools       = [[FRTools alloc] initWithTools];
    delegate    = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    adManager   = [[HSMAd alloc] initWithManager];
    
    NSMutableArray *arrayMenu = [tools propertyListRead:PLIST_MENU];
    NSDictionary *ad = [adManager adForType:kAdBannerMenu];
    
    // ad..
    if ([ad count] > 0)
        [arrayMenu addObject:ad];
    
    tableData   = [arrayMenu copy];
    
    UIImageView *tableHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_header.png"]];
    UIImageView *tableFooter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_footer.png"]];
    [table setTableHeaderView:tableHeader];
    [table setTableFooterView:tableFooter];
    
    [[self view] setBackgroundColor:COLOR_MENU_BACKGROUND];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
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
    NSDictionary *dict = [tableData objectAtIndex:indexPath.row];
    if([[dict objectForKey:KEY_TYPE] isEqualToString:@"ads"])
        return 50;
    else
        return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imgBg, *imgBgSel;
    UIImage *imgIcon;
    NSDictionary *dict  = [tableData objectAtIndex:[indexPath row]];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    MenuCell *cell      = (MenuCell*)[xib objectAtIndex:kCellMenu];
    
    // ads..
    if ([[dict objectForKey:KEY_TYPE] isEqualToString:@"ads"]) {
        NSArray *xib            = [[NSBundle mainBundle] loadNibNamed:AD_RESOURCES owner:nil options:nil];
        HSMAdBannerMenu *adView = (HSMAdBannerMenu*)[xib objectAtIndex:kAdBannerMenu];
        
        [adView setHsmAdId:[dict objectForKey:KEY_ID]];
        [[adView button] addTarget:adView action:@selector(performAd:) forControlEvents:UIControlEventTouchUpInside];
        [adView setImageURL:[NSString stringWithFormat:@"%@/ads/%@", URL_ADS_UPLOADS, [dict objectForKey:KEY_IMAGE]]];
        [adView commit];
        
        imgBg       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_cell.png"]];
        [cell setBackgroundView:imgBg];
        
        [cell addSubview:adView];
    }
    // menu option..
    else {
        
        if ([[dict objectForKey:KEY_IS_ACTIVE] isEqualToString:KEY_YES])
        {
            imgBg       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_cell.png"]];
            imgBgSel    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_cell_sel.png"]];
        }
        else
        {
            imgBg       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_cell_soon.png"]];
            imgBgSel    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_v5_menu_cell_soon_sel.png"]];
        }
        
        imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"hsm_v5_menu_id_%@.png", [dict objectForKey:KEY_SLUG]]];
        [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
        [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
        [[cell imgIcon] setImage:imgIcon];
        
        [cell setBackgroundView:imgBg];
        [cell setSelectedBackgroundView:imgBgSel];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [tableData objectAtIndex:indexPath.row];
    HSMMenuRows selectedRow = indexPath.row;
    MenuCell *cell  = (MenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    UIImage *imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"hsm_v5_menu_id_%@_sel.png", [dict objectForKey:KEY_SLUG]]];
    [[cell imgIcon] setImage:imgIcon];
    [[cell labText] setTextColor:[UIColor whiteColor]];
    
    // ...
    switch (selectedRow) {
        // ... home
        case kMenuHome:
        {
            Home *c = [[Home alloc] initWithNibName:NIB_HOME bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
            break;
        // ... eventos
        case kMenuEvents:
        {
            Events *c = [[Events alloc] initWithNibName:NIB_EVENTS bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
            break;
        // ... livros
        case kMenuBooks:
        {
            Books *c = [[Books alloc] initWithNibName:NIB_BOOKS bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
            break;
        // ... revistas
        case kMenuIssues:
        {
            Magazines *c = [[Magazines alloc] initWithNibName:NIB_MAGAZINES bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
            break;
        // ... network
        case kMenuNetwork:
        {
            Network *c = [[Network alloc] initWithNibName:NIB_NETWORK bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
            break;
        // tv..
        case kMenuTV:
        {
            NSString *strURL = @"http://www.youtube.com/watch?v=ZHolmn4LBzg";
            NSURL *url = [ [ NSURL alloc ] initWithString: strURL ];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        // ... soon
        //case kMenuNews:
        case kMenuEducation:
        {
            [tools dialogWithMessage:@"Este conteúdo estará disponível em breve." cancelButton:@"OK" title:@"Conteúdo Indisponível"];
        }
            break;
        // ... configurações
        case kMenuSettings:
        {
            //
        }
            break;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [tableData objectAtIndex:indexPath.row];
    MenuCell *cell  = (MenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    UIImage *imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"hsm_v5_menu_id_%@.png", [dict objectForKey:KEY_SLUG]]];
    [[cell imgIcon] setImage:imgIcon];
}

@end
