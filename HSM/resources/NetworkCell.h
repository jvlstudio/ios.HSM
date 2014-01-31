//
//  NetworkCell.h
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *labText;
@property (nonatomic, strong) IBOutlet UILabel *labSubtext;
@property (nonatomic, strong) IBOutlet UIImageView *imgColor;
@property (nonatomic, strong) IBOutlet UIImageView *imgOpt;

@end
