//
//  Books.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Books.h"
#import "BookCell.h"
#import "BookSingle.h"

#import "PassButton.h"

#define CELL_HEIGHT     129.0
#define CELL_IDENTIFIER @"bookCell"
#define CELL_BG         @"hsm_books_cell.png"

@interface Books ()
- (void) pushWithNumber:(NSInteger) number;
@end

@implementation Books
{
    FRTools *tools;
    NSArray *rows;
}

@synthesize table;
@synthesize tableData;

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    [self setTitle:@"Livros"];
    
    // table data..
    tools       = [[FRTools alloc] initWithTools];
    tableData   = [tools propertyListRead:PLIST_BOOKS];
    rows        = [NSArray arrayWithObjects:
                   [NSArray arrayWithObjects:@"0", @"1", @"2", nil],
                   [NSArray arrayWithObjects:@"3", @"4", @"5", nil],
                   [NSArray arrayWithObjects:@"6", @"7", @"8", nil],
                   [NSArray arrayWithObjects:@"9", @"10", @"11", nil], nil];
    
    [table setTableHeaderView:[self edge]];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark -
#pragma mark IBActions

- (void) pressBook1:(id)sender
{
    PassButton *pbt         = (PassButton*)sender;
    NSIndexPath *indexPath  = [pbt cellIndexPath];
    [self pushWithNumber:[[[rows objectAtIndex:indexPath.row] objectAtIndex:0] intValue]];
}
- (void) pressBook2:(id)sender
{
    PassButton *pbt         = (PassButton*)sender;
    NSIndexPath *indexPath  = [pbt cellIndexPath];
    [self pushWithNumber:[[[rows objectAtIndex:indexPath.row] objectAtIndex:1] intValue]];
}
- (void) pressBook3:(id)sender
{
    PassButton *pbt         = (PassButton*)sender;
    NSIndexPath *indexPath  = [pbt cellIndexPath];
    [self pushWithNumber:[[[rows objectAtIndex:indexPath.row] objectAtIndex:2] intValue]];
}
- (void) pushWithNumber:(NSInteger) number
{
    NSDictionary *dict      = [tableData objectAtIndex:number];
    BookSingle *vc          = [[BookSingle alloc] initWithNibName:NIB_BOOK_SINGLE andDictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger calc1     = [[[rows objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    NSInteger calc2     = [[[rows objectAtIndex:indexPath.row] objectAtIndex:1] intValue];
    NSInteger calc3     = [[[rows objectAtIndex:indexPath.row] objectAtIndex:2] intValue];
    
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    BookCell *cell      = (BookCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if(!cell)
        cell = (BookCell*)[xib objectAtIndex:kCellBooks];
    
    // ...
    UIImageView *imgBg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_BG]];
    [cell setBackgroundView:imgBg];
    
    PassButton *but1, *but2, *but3;
    but1 = (PassButton*)[cell butBook1];
    but2 = (PassButton*)[cell butBook2];
    but3 = (PassButton*)[cell butBook3];
    
    // but 1...
    if(calc1 < [tableData count])
    {
        NSDictionary *dict = [tableData objectAtIndex:calc1];
        
        [but1 setCellIndexPath:indexPath];
        [but1 addTarget:self action:@selector(pressBook1:) forControlEvents:UIControlEventTouchUpInside];
        [but1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [dict objectForKey:KEY_SLUG]]] forState:UIControlStateNormal];
    }
    else [but1 setHidden:YES];
    
    // but 2...
    if(calc2 < [tableData count])
    {
        NSDictionary *dict = [tableData objectAtIndex:calc2];
        
        [but2 setCellIndexPath:indexPath];
        [but2 addTarget:self action:@selector(pressBook2:) forControlEvents:UIControlEventTouchUpInside];
        [but2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [dict objectForKey:KEY_SLUG]]] forState:UIControlStateNormal];
    }
    else [but2 setHidden:YES];
    
    // but 3...
    if(calc3 < [tableData count])
    {
        NSDictionary *dict = [tableData objectAtIndex:calc3];
        
        [but3 setCellIndexPath:indexPath];
        [but3 addTarget:self action:@selector(pressBook3:) forControlEvents:UIControlEventTouchUpInside];
        [but3 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [dict objectForKey:KEY_SLUG]]] forState:UIControlStateNormal];
    }
    else [but3 setHidden:YES];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // ...
}

@end
