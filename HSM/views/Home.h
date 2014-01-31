//
//  Home.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface Home : KDViewController
{
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    
    IBOutlet UIButton *butExpo;
    IBOutlet UIButton *butEducation;
    IBOutlet UIButton *butTV;
    IBOutlet UIButton *butIssues;
    IBOutlet UIButton *butBooks;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressExpo:(id)sender;
- (IBAction) pressEducation:(id)sender;
- (IBAction) pressTV:(id)sender;
- (IBAction) pressIssues:(id)sender;
- (IBAction) pressBooks:(id)sender;

@end
