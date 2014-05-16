//
//  Magazines.h
//  HSM
//
//  Created by Felipe Ricieri on 05/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface Magazines : KDViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
    
    IBOutlet UITableView *table;
    IBOutlet UIImageView *tableHeader;
}

#pragma mark - IBActions

- (void) pressButton:(id)sender;

@end
