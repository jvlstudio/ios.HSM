//
//  Events.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface Events : KDViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
    IBOutlet UITableView *table;
}

@end