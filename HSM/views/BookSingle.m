//
//  BookSingle.m
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "BookSingle.h"

@implementation BookSingle

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
    [self setTitle:@"Livro"];
    
    [labTitle setText:[[self dictionary] objectForKey:KEY_NAME]];
    [labSubtitle setText:[[self dictionary] objectForKey:KEY_SUBTITLE]];
    [labTitle setFont:[UIFont fontWithName:FONT_REGULAR size:labTitle.font.pointSize]];
    [labSubtitle setFont:[UIFont fontWithName:FONT_REGULAR size:labSubtitle.font.pointSize]];
    
    [labTitle alignBottom];
    [labSubtitle alignTop];
    
    [labPrice setText:@"consulte"];
    [labAuthor setText:[[self dictionary] objectForKey:KEY_AUTHOR_NAME]];
    [especDimensions setText:[[self dictionary] objectForKey:KEY_DIMENSIONS]];
    [especPages setText:[[self dictionary] objectForKey:KEY_PAGES]];
    [especCodebarBook setText:[[self dictionary] objectForKey:KEY_CODEBAR_BOOK]];
    [especCodebarEBook setText:[[self dictionary] objectForKey:KEY_CODEBAR_EBOOK]];
    [tvSinopse setText:[[self dictionary] objectForKey:KEY_DESCRIPTION]];
    [tvAuthor setText:[[self dictionary] objectForKey:KEY_AUTHOR_DESCRIPTION]];
    
    NSString *strImg    = [NSString stringWithFormat:@"%@.png", [[self dictionary] objectForKey:KEY_SLUG]];
    [imgPicture setImage:[UIImage imageNamed:strImg]];
    
    // scr..
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
    
    // scr sub..
    CGRect rect1    = vEspec.frame;
    rect1.origin.x  = WINDOW_WIDTH;
    [vEspec setFrame:rect1];
    
    CGRect rect2    = vAuthor.frame;
    rect2.origin.x  = WINDOW_WIDTH*2;
    [vAuthor setFrame:rect2];
    
    [scrSub setContentSize:CGSizeMake(WINDOW_WIDTH*3, scrSub.frame.size.height)];
    [scrSub addSubview:vDescription];
    [scrSub addSubview:vEspec];
    [scrSub addSubview:vAuthor];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressBuy:(id)sender
{
    NSString *strURL = [[self dictionary] objectForKey:KEY_LINK];
    NSURL *url = [ [ NSURL alloc ] initWithString: strURL ];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction) segmentChange:(UISegmentedControl*)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [UIView animateWithDuration:0.5f animations:^{
                [scrSub setContentOffset:CGPointMake(ZERO, ZERO)];
            }];
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.5f animations:^{
                [scrSub setContentOffset:CGPointMake(WINDOW_WIDTH, ZERO)];
            }];
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.5f animations:^{
                [scrSub setContentOffset:CGPointMake((WINDOW_WIDTH*2), ZERO)];
            }];
        }
            break;
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == scrSub)
    {
        CGPoint offset = scrollView.contentOffset;
        if (offset.x == ZERO)
        {
            [segment setSelectedSegmentIndex:0];
        }
        if (offset.x == WINDOW_WIDTH)
        {
            [segment setSelectedSegmentIndex:1];
        }
        if (offset.x == (WINDOW_WIDTH*2))
        {
            [segment setSelectedSegmentIndex:2];
        }
    }
}

@end
