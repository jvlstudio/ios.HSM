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
    IBOutlet UISegmentedControl* segment;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) segmentChanged:(UISegmentedControl*)sender;

@end
