//
//  AgendaShowCell.h
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaShowCell : UITableViewCell
{
    IBOutlet UILabel *labText;
    IBOutlet UILabel *labSubText;
    IBOutlet UILabel *labHourInit;
    IBOutlet UILabel *labHourFinal;
}

@property (nonatomic, strong) IBOutlet UILabel *labText;
@property (nonatomic, strong) IBOutlet UILabel *labSubText;
@property (nonatomic, strong) IBOutlet UILabel *labHourInit;
@property (nonatomic, strong) IBOutlet UILabel *labHourFinal;

@end
