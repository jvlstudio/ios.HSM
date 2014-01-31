//
//  AgendaBreakCell.h
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaBreakCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *labText;
@property (nonatomic, strong) IBOutlet UILabel *labHourInit;
@property (nonatomic, strong) IBOutlet UILabel *labHourFinal;
@property (nonatomic, strong) IBOutlet UIImageView *imgIcon;

@end
