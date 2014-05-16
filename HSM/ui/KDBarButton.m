//
//  KDBarButton.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDBarButton.h"

#define BUTTON_MENU     @"hsm_v5_nav_menu.png"
#define BUTTON_BACK     @"hsm_v5_nav_back.png"
#define BUTTON_CLOSE    @"hsm_bt_close.png"
#define BUTTON_SCAN     @"hsm_v5_nav_scan.png"
#define BUTTON_EMPTY    @"hsm_v5_nav_empty.png"

@implementation KDBarButton

- (id) initWithMenu:(SEL)selector toTarget:(id)target
{
    UIButton *button = [self newButton:BUTTON_MENU];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:button];
    return self;
}
- (id) initWithBack:(SEL)selector toTarget:(id)target
{
    UIButton *button = [self newButton:BUTTON_BACK];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:button];
    return self;
}
- (id) initWithClose:(SEL)selector toTarget:(id)target
{
    //UIButton *button = [self newButton:BUTTON_CLOSE];
    //[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithTitle:@"Fechar" style:UIBarButtonItemStylePlain target:target action:selector];
    return self;
}
- (id)initWithScan:(SEL)selector toTarget:(id)target
{
    UIButton *button = [self newButton:BUTTON_SCAN];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:button];
    return self;
}
- (id) initWithEmpty
{
    UIButton *button = [self newButton:BUTTON_EMPTY];
    self = [super initWithCustomView:button];
    return self;
}

#pragma mark -
#pragma mark Methods

- (UIButton *)newButton:(NSString *)image
{
    UIImage *img = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:img forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, img.size.width+7, img.size.height);
    
    return button;
}

@end
