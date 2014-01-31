//
//  BookSingle.m
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "BookSingle.h"

@interface BookSingle ()
- (void) allButtonsUp;
- (void) setInfo;
@end

@implementation BookSingle

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setTitle:[NSString stringWithFormat:@"Livro: %@", [[self dictionary] objectForKey:KEY_NAME]]];
    [self setInfo];
    
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
    [scrSub addSubview:tvSinopse];
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
- (IBAction) pressSinopse:(id)sender
{
    [self allButtonsUp];
    [butSinopse setSelected:YES];
    // ..
    [UIView animateWithDuration:0.5f animations:^{
        [scrSub setContentOffset:CGPointMake(ZERO, ZERO)];
    }];
}
- (IBAction) pressEspec:(id)sender
{
    [self allButtonsUp];
    [butEspec setSelected:YES];
    // ..
    [UIView animateWithDuration:0.5f animations:^{
        [scrSub setContentOffset:CGPointMake(WINDOW_WIDTH, ZERO)];
    }];
}
- (IBAction) pressAuthor:(id)sender
{
    [self allButtonsUp];
    [butAuthor setSelected:YES];
    // ..
    [UIView animateWithDuration:0.5f animations:^{
        [scrSub setContentOffset:CGPointMake((WINDOW_WIDTH*2), ZERO)];
    }];
}

#pragma mark -
#pragma mark Methods

- (void) allButtonsUp
{
    [butSinopse setSelected:NO];
    [butEspec setSelected:NO];
    [butAuthor setSelected:NO];
}
- (void) setInfo
{
    [labTitle setText:[[self dictionary] objectForKey:KEY_NAME]];
    [labSubtitle setText:[[self dictionary] objectForKey:KEY_SUBTITLE]];
    
    [labTitle alignBottom];
    [labSubtitle alignTop];
    
    [labPrice setText:[[self dictionary] objectForKey:KEY_PRICE]];
    [labAuthor setText:[[self dictionary] objectForKey:KEY_AUTHOR_NAME]];
    [especDimensions setText:[[self dictionary] objectForKey:KEY_DIMENSIONS]];
    [especPages setText:[[self dictionary] objectForKey:KEY_PAGES]];
    [especCodebarBook setText:[[self dictionary] objectForKey:KEY_CODEBAR_BOOK]];
    [especCodebarEBook setText:[[self dictionary] objectForKey:KEY_CODEBAR_EBOOK]];
    [tvSinopse setText:[[self dictionary] objectForKey:KEY_DESCRIPTION]];
    [tvAuthor setText:[[self dictionary] objectForKey:KEY_AUTHOR_DESCRIPTION]];
    
    NSString *strImg    = [NSString stringWithFormat:@"%@.png", [[self dictionary] objectForKey:KEY_SLUG]];
    [imgPicture setImage:[UIImage imageNamed:strImg]];
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
            [self allButtonsUp];
            //[[self butSinopse] setSelected:YES];
            [butSinopse setSelected:YES];
        }
        if (offset.x == WINDOW_WIDTH)
        {
            [self allButtonsUp];
            //[[self butEspec] setSelected:YES];
            [butEspec setSelected:YES];
        }
        if (offset.x == (WINDOW_WIDTH*2))
        {
            [self allButtonsUp];
            //[[self butAuthor] setSelected:YES];
            [butAuthor setSelected:YES];
        }
    }
}

@end
