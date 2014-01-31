//
//  AgendaCell.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *labText;
@property (nonatomic, strong) IBOutlet UILabel *labSubText;
@property (nonatomic, strong) IBOutlet UILabel *labHourInit;
@property (nonatomic, strong) IBOutlet UILabel *labHourFinal;
@property (nonatomic, strong) IBOutlet UIImageView *imgPicture;

@end
