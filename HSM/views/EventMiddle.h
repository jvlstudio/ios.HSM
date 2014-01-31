//
//  EventMiddle.h
//  HSM
//
//  Created by Felipe Ricieri on 23/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface EventMiddle : KDViewController
{
    IBOutlet UIButton *butBDW;
    IBOutlet UIButton *butMostra;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressBDW:(id)sender;
- (IBAction) pressMostra:(id)sender;


@end
