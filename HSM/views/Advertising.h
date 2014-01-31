//
//  Advertising.h
//  HSM
//
//  Created by Felipe Ricieri on 18/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Advertising : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *but;
@property (nonatomic, strong) IBOutlet UIImageView *img;

- (id) initOnView:(UIView*) sview;
- (void) correctRectOfView:(UIView*) sview;

- (IBAction) pressAd:(id)sender;

@end
