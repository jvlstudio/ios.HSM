//
//  MagazineCell.h
//  HSM
//
//  Created by Felipe Ricieri on 05/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineCell : UITableViewCell
{
    IBOutlet UILabel *labTitle;
    IBOutlet UILabel *labSlug;
    IBOutlet UIImageView *image;
    IBOutlet UIButton *button;
}

@property (nonatomic, strong) IBOutlet UILabel *labTitle;
@property (nonatomic, strong) IBOutlet UILabel *labSlug;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UIButton *button;

@end
