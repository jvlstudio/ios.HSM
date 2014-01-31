//
//  BookSingle.h
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface BookSingle : KDViewController <UIScrollViewDelegate>
{
    IBOutlet UIView *v;
    IBOutlet UIView *vEspec;
    IBOutlet UIView *vAuthor;
    IBOutlet UIScrollView *scr;
    IBOutlet UIScrollView *scrSub;
    
    IBOutlet UILabel *labTitle;
    IBOutlet UILabel *labSubtitle;
    IBOutlet UILabel *labPrice;
    IBOutlet UILabel *labAuthor;
    IBOutlet UILabel *especDimensions;
    IBOutlet UILabel *especPages;
    IBOutlet UILabel *especCodebarBook;
    IBOutlet UILabel *especCodebarEBook;
    
    IBOutlet UIButton *butBuy;
    IBOutlet UIButton *butSinopse;
    IBOutlet UIButton *butEspec;
    IBOutlet UIButton *butAuthor;
    
    IBOutlet UIImageView *imgPicture;
    
    IBOutlet UITextView *tvSinopse;
    IBOutlet UITextView *tvAuthor;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressBuy:(id)sender;
- (IBAction) pressSinopse:(id)sender;
- (IBAction) pressEspec:(id)sender;
- (IBAction) pressAuthor:(id)sender;

@end
