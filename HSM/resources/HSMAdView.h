//
//  HSMAdView.h
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Constants

#define AD_URL      @"http://apps.ikomm.com.br/hsm5/graph/ads-link.php"

#pragma mark - Interface

@interface HSMAdView : UIView
{
    NSString *hsmAdId;
    NSString *imageURL;
    
    IBOutlet UIImageView *image;
    IBOutlet UIButton *button;
}

@property (nonatomic, strong) NSString *hsmAdId;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UIButton *button;

#pragma mark -
#pragma mark Methods

- (void) commit;
- (void) performAd:(UIButton*)sender;

@end
