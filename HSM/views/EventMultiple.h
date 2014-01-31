//
//  EventMultiple.h
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface EventMultiple : KDViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
    IBOutlet UITableView *table;
}

@end
