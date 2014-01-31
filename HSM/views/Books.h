//
//  Books.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface Books : KDViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) IBOutlet UITableView *table;

#pragma mark -
#pragma mark IBActions

- (void) pressBook1:(id)sender;
- (void) pressBook2:(id)sender;
- (void) pressBook3:(id)sender;

@end
