//
//  BookCell.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCell : UITableViewCell
{
    IBOutlet UIButton *butBook1;
    IBOutlet UIButton *butBook2;
    IBOutlet UIButton *butBook3;
    IBOutlet UILabel *labBook1;
    IBOutlet UILabel *labBook2;
    IBOutlet UILabel *labBook3;
}

@property (nonatomic, strong) IBOutlet UIButton *butBook1;
@property (nonatomic, strong) IBOutlet UIButton *butBook2;
@property (nonatomic, strong) IBOutlet UIButton *butBook3;
@property (nonatomic, strong) IBOutlet UILabel *labBook1;
@property (nonatomic, strong) IBOutlet UILabel *labBook2;
@property (nonatomic, strong) IBOutlet UILabel *labBook3;


@end
