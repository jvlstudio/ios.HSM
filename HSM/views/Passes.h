//
//  Passes.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassViewController.h"

@interface Passes : PassViewController
{
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    
    // green
    IBOutlet UIView *greenView;
    IBOutlet UILabel *greenName;
    IBOutlet UILabel *greenDescription;
    IBOutlet UILabel *greenValue;
    IBOutlet UILabel *greenValueSpecial;
    IBOutlet UILabel *greenValidate;
    
    // gold
    IBOutlet UIView *goldView;
    IBOutlet UILabel *goldName;
    IBOutlet UILabel *goldDescription;
    IBOutlet UILabel *goldValue;
    IBOutlet UILabel *goldValueSpecial;
    IBOutlet UILabel *goldValidate;
    
    // red
    IBOutlet UIView *redView;
    IBOutlet UILabel *redName;
    IBOutlet UILabel *redDescription;
    IBOutlet UILabel *redValue;
    IBOutlet UILabel *redValueSpecial;
    IBOutlet UILabel *redValidate;
    
    IBOutlet UIButton *butGreen;
    IBOutlet UIButton *butGold;
    IBOutlet UIButton *butRed;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressGreen:(id)sender;
- (IBAction) pressGold:(id)sender;
- (IBAction) pressRed:(id)sender;

@end
