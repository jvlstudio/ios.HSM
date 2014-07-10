//
//  Panelist.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Panelist.h"
#import "PanelistCell.h"
#import "PanelistSingle.h"

#define CELL_IDENTIFIER     @"panelistCell"

#pragma mark - Interface

@interface Panelist ()
- (void) pressPanelist:(id) sender;
@end

#pragma mark - Implementation

@implementation Panelist

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Palestrantes"];
    
    // table data..
    panelists   = [self array];
    v           = [[UIView alloc] initWithFrame:self.view.frame];
    [v setBackgroundColor:[UIColor clearColor]];
    
    CGRect rect = scr.frame;
    rect.size.height -= IPHONE5_COEF;
    [scr setFrame:rect];
    
    int point   = 0;
    int rows    = 3;
    int col     = 0;
    
    for (NSDictionary *dict in panelists)
    {
        // data..
        NSArray *xib                = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
        PanelistCell *panelistView  = (PanelistCell*)[xib objectAtIndex:kCellPanelist];
        
        NSString *strImg = [dict objectForKey:@"picture"];
		if(strImg)
			[[panelistView imgPicture] setImageWithURL:[NSURL URLWithString:strImg]];
        [[panelistView labText] setText:[dict objectForKey:KEY_NAME]];
        [[panelistView but] setTag:point];
        [[panelistView but] addTarget:self action:@selector(pressPanelist:) forControlEvents:UIControlEventTouchUpInside];
        
        // check ..
        float row = point%rows;
        if (row < 1 && point > 2)
            col += panelistView.frame.size.height;
        
        // rects ..
        CGRect rectPan       = panelistView.frame;
        //rectPan.origin.y    += 75; // correct..
        rectPan.origin.y    += col;
        rectPan.origin.x     = 10+(rectPan.size.width*row);
        [panelistView setFrame:rectPan];
        
        CGRect rectV         = v.frame;
        rectV.size.height    = col; // +correct..
        // finish.. (correct)
        if (point == ([panelists count]-1))
            rectV.size.height += panelistView.frame.size.height;
        [v setFrame:rectV];
        [v addSubview:panelistView];
        
        point++;
    }
    
    // scr..
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
    
    // ad..
    //Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    //[ad correctRectOfView:scr];
    if ([adManager hasAdWithCategory:kAdBannerFooter])
        [adManager addAdTo:scr type:kAdBannerFooter];
}

#pragma mark -
#pragma mark Methods

- (void) pressPanelist:(id)sender
{
    UIButton *but       = (UIButton*) sender;
    NSDictionary *dict  = [panelists objectAtIndex:but.tag];
    PanelistSingle *single  = [[PanelistSingle alloc] initWithNibName:NIB_PANELIST_SINGLE andDictionary:dict];
    [[self navigationController] pushViewController:single animated:YES];
}

@end
