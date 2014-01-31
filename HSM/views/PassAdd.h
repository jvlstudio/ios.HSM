//
//  PassAdd.h
//  HSM
//
//  Created by Felipe Ricieri on 07/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassViewController.h"

@interface PassAdd : PassViewController <UITextFieldDelegate, UIScrollViewDelegate>
{
    NSIndexPath *indexPath;
    
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    
    IBOutlet UILabel *labText;
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfEmail;
    IBOutlet UITextField *tfCPF;
    IBOutlet UITextField *tfCompany;
    IBOutlet UITextField *tfRole;
    IBOutlet UIButton *but;
}

#pragma mark -
#pragma mark Init Methods

- (id) initWithPassColor:(PassColor)color andIndexPath:(NSIndexPath*) ip;

#pragma mark -
#pragma mark IBActions

- (IBAction) pressConfirm:(id)sender;

@end
