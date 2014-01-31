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

@property (nonatomic, strong) NSString *zBarSymbolData;
@property (nonatomic, strong) ZBarReaderViewController *zBarReader;

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) IBOutlet UITableView *table;

/* self */

@property (nonatomic, strong) IBOutlet UIView *selfView;
@property (nonatomic, strong) IBOutlet UIImageView *selfColor;
@property (nonatomic, strong) IBOutlet UILabel *selfTitle;
@property (nonatomic, strong) IBOutlet UILabel *selfSubtitle;

@property (nonatomic, strong) IBOutlet UIView *createView;
@property (nonatomic, strong) IBOutlet UIButton *butCreate;
@property (nonatomic, strong) IBOutlet UIButton *butSelf;

#pragma mark -
#pragma mark IBActions

- (IBAction) pressCreate:(id)sender;
- (IBAction) pressSelf:(id)sender;
- (void) pressScan:(id)sender;

@end
