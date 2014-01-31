//
//  PassFormCell.h
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassFormCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *labText;
@property (nonatomic, strong) IBOutlet UITextField *tfName;
@property (nonatomic, strong) IBOutlet UITextField *tfEmail;
@property (nonatomic, strong) IBOutlet UITextField *tfCompany;
@property (nonatomic, strong) IBOutlet UITextField *tfRole;

@end
