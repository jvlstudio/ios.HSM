//
//  Agenda.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface Agenda : KDViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *agendaDays;
    NSMutableArray *scheduleDays;
    NSArray *tableData;
    
    IBOutlet UITableView *table;
    IBOutlet UIView *tableHeader;
    IBOutlet UIButton *butDay1;
    IBOutlet UIButton *butDay2;
    IBOutlet UIButton *butDay3;
    IBOutlet UIImageView *imgButDay1;
    IBOutlet UIImageView *imgButDay2;
    IBOutlet UIImageView *imgButDay3;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressDay1:(id)sender;
- (IBAction) pressDay2:(id)sender;
- (IBAction) pressDay3:(id)sender;

@end
