//
//  AgendaButtonDay.h
//  HSM
//
//  Created by Felipe Ricieri on 05/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaButtonDay : UIView
{
    IBOutlet UILabel *labDay;
    IBOutlet UILabel *labMonth;
    IBOutlet UIImageView *background;
    IBOutlet UIButton *button;
}

@property (nonatomic, strong) IBOutlet UILabel *labDay;
@property (nonatomic, strong) IBOutlet UILabel *labMonth;
@property (nonatomic, strong) IBOutlet UIImageView *background;
@property (nonatomic, strong) IBOutlet UIButton *button;

@end
