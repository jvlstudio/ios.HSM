//
//  PassForm.h
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassViewController.h"

@interface PassForm : PassViewController
<UITableViewDelegate, UITableViewDataSource,
UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *plist;
    NSDictionary *passData;
    NSArray *passSections;
    NSArray *dates;
    
    IBOutlet UITableView *table;
    IBOutlet UIView *tableHeader;
    IBOutlet UIImageView *imgHeader;
    IBOutlet UIView *tableFooter;
    IBOutlet UIPickerView *pvDates;
    IBOutlet UIPickerView *pvPayment;
    IBOutlet UIButton *but;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressConfirm:(id)sender;
- (void) pressDelete:(id)sender;

@end
