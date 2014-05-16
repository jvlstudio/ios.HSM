//
//  Network.h
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NetworkViewController.h"
#import "NetworkDelegate.h"
#import "ZBarSDK.h"

@interface Network : NetworkViewController
<UITableViewDelegate, UITableViewDataSource, NetworkDelegate, ZBarReaderDelegate>
{
    NSString *zBarSymbolData;
    NSArray *tableData;
    
    ZBarReaderViewController *zBarReader;
    
    IBOutlet UITableView *table;
    IBOutlet UIView *selfView;
    IBOutlet UIImageView *selfColor;
    IBOutlet UILabel *selfTitle;
    IBOutlet UILabel *selfSubtitle;
    IBOutlet UIView *createView;
    IBOutlet UIButton *butCreate;
    IBOutlet UIButton *butSelf;
}

@property (nonatomic, strong) IBOutlet UITableView *table;

#pragma mark -
#pragma mark IBActions

- (IBAction) pressCreate:(id)sender;
- (IBAction) pressSelf:(id)sender;
- (void) pressScan:(id)sender;

@end
