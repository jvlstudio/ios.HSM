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
#import "Network.h"

#define CELL_HEIGHT     50.0
#define CELL_IDENTIFIER @"menuCell"

@interface Menu ()

@end

@implementation Menu
{
    FRTools *tools;
}

@synthesize table;
@synthesize tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // table data..
    tools       = [[FRTools alloc] initWithTools];
    tableData   = [tools propertyListRead:PLIST_MENU];
    
    UIImageView *tableHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_menu_header.png"]];
    UIImageView *tableFooter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_menu_footer.png"]];
    [table setTableHeaderView:tableHeader];
    [table setTableFooterView:tableFooter];
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
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imgBg, *imgBgSel;
    UIImage *imgIcon;
    NSDictionary *dict  = [tableData objectAtIndex:[indexPath row]];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    MenuCell *cell      = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if(!cell)
        cell = (MenuCell*)[xib objectAtIndex:kCellMenu];
    
    if ([[dict objectForKey:KEY_IS_ACTIVE] isEqualToString:KEY_YES])
    {
        imgBg       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_menu_cell.png"]];
        imgBgSel    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_menu_cell_sel.png"]];
    }
    else
    {
        imgBg       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_menu_cell_soon.png"]];
        imgBgSel    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hsm_menu_cell_soon_sel.png"]];
    }
    
    imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"hsm_menu_id_%@.png", [dict objectForKey:KEY_SLUG]]];
    [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
    [[cell imgIcon] setImage:imgIcon];
    
    [cell setBackgroundView:imgBg];
    [cell setSelectedBackgroundView:imgBgSel];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [tableData objectAtIndex:indexPath.row];
    HSMMenuRows selectedRow = indexPath.row;
    MenuCell *cell  = (MenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    UIImage *imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"hsm_menu_id_%@_sel.png", [dict objectForKey:KEY_SLUG]]];
    [[cell imgIcon] setImage:imgIcon];
    
    // ...
    switch (selectedRow) {
        // ... home
        case kMenuHome:
        {
            Home *c = [[Home alloc] initWithNibName:NIB_HOME bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
            PP_RELEASE(c);
            PP_RELEASE(n);
        }
            break;
        // ... eventos
        case kMenuEvents:
        {
            Events *c = [[Events alloc] initWithNibName:NIB_EVENTS bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
            PP_RELEASE(c);
            PP_RELEASE(n);
        }
            break;
        // ... livros
        case kMenuBooks:
        {
            Books *c = [[Books alloc] initWithNibName:NIB_BOOKS bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
            PP_RELEASE(c);
            PP_RELEASE(n);
        }
            break;
        // ... network
        case kMenuNetwork:
        {
            Network *c = [[Network alloc] initWithNibName:NIB_NETWORK bundle:nil];
            UINavigationController *n;
            n = [[UINavigationController alloc] initWithRootViewController:c];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
            PP_RELEASE(c);
            PP_RELEASE(n);
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
        //case kMenuBooks:
        case kMenuIssues:
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
    
    UIImage *imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"hsm_menu_id_%@.png", [dict objectForKey:KEY_SLUG]]];
    [[cell imgIcon] setImage:imgIcon];
}

@end
