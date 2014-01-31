//
//  NetworkSingle.h
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NetworkViewController.h"
#import <MessageUI/MessageUI.h>

@interface NetworkSingle : NetworkViewController <MFMailComposeViewControllerDelegate>
{
    NSDictionary *contact;
    
    IBOutlet UILabel *labName;
    IBOutlet UILabel *labName2;
    IBOutlet UILabel *labEmail;
    IBOutlet UILabel *labCompany;
    IBOutlet UILabel *labRole;
    IBOutlet UILabel *labPhone;
    IBOutlet UILabel *labMobile;
    IBOutlet UIView *blackView;
    
    IBOutlet UIImageView *imgColor;
    IBOutlet UIImageView *imgQRCode;
    
    IBOutlet UIButton *butAddContact;
    IBOutlet UIButton *butSendEmail;
    IBOutlet UIButton *butBlack;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressAddContact:(id)sender;
- (IBAction) pressSendEmail:(id)sender;
- (IBAction) pressBlack:(id)sender;

@end
