//
//  Menu.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HSMAd.h"

@interface Menu : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) IBOutlet UITableView *table;

@end
