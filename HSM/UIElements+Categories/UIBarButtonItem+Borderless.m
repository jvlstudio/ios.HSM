//
//  UIBarButtonItem+Borderless.m
//  T-APL
//
//  Created by Felipe Ricieri on 20/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "UIBarButtonItem+Borderless.h"


@implementation UIBarButtonItem (Borderless)

#pragma mark -
#pragma mark Methods

- (id) initWithSelector:(SEL)selector andImage:(NSString*) image toTarget:(id)target
{
    UIButton *button = [self newButton:image];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    self = [self initWithCustomView:button];
    return self;
}

- (UIButton*) newButton:(NSString *)image
{
    UIImage *img = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:img forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, img.size.width+7, img.size.height);
    
    return button;
}

@end
