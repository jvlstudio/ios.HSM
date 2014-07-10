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
	NSArray *dates;
	
    NSArray *agendaDays;
    NSMutableArray *scheduleDays;
    NSArray *tableData;
    
    IBOutlet UITableView *table;
    IBOutlet UIView *tableHeader;
    IBOutlet UISegmentedControl* segment;
}

@property (nonatomic, strong) NSArray *dates;

#pragma mark -
#pragma mark IBActions

- (IBAction) segmentChanged:(UISegmentedControl*)sender;

@end
