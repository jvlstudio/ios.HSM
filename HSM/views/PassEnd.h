//
//  PassEnd.h
//  HSM
//
//  Created by Felipe Ricieri on 07/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassViewController.h"

@interface PassEnd : PassViewController
{
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    IBOutlet UIButton *but;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressBt:(id)sender;

@end
