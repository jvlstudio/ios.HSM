//
//  NetworkSign.h
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NetworkViewController.h"

@interface NetworkSign : NetworkViewController <UITextFieldDelegate, UIScrollViewDelegate, UIActionSheetDelegate>
{
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    IBOutlet UIButton *butCreate;
    
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfEmail;
    IBOutlet UITextField *tfPhone;
    IBOutlet UITextField *tfMobile;
    IBOutlet UITextField *tfCompany;
    IBOutlet UITextField *tfRole;
    IBOutlet UITextField *tfWebsite;
    
    UIActionSheet *actsheet;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) doneEditing:(id)sender;
- (IBAction) pressCreate:(id)sender;

@end
