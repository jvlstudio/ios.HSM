//
//  PanelistSingle.h
//  HSM
//
//  Created by Felipe Ricieri on 03/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface PanelistSingle : KDViewController <UIScrollViewDelegate>
{
    UITextView *tvDescription;
    UITextView *tvTheme;
    UILabel *labThemeTitle;
    
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    
    IBOutlet UILabel *labName;
    IBOutlet UILabel *labSpeech;
    IBOutlet UILabel *labDate;
    IBOutlet UILabel *labHour;
    
    IBOutlet UIButton *butSchedule;
    IBOutlet UIImageView *imgPicture;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressSchedule:(id)sender;

@end
