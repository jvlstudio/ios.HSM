//
//  EventCell.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *labText;
@property (nonatomic, strong) IBOutlet UILabel *labSubtext;
@property (nonatomic, strong) IBOutlet UILabel *labDates;
@property (nonatomic, strong) IBOutlet UILabel *labLocation;
@property (nonatomic, strong) IBOutlet UIImageView *imgCover;

@end
