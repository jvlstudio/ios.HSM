//
//  UIView+Addons.m
//  T-APL
//
//  Created by Felipe Ricieri on 22/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "UIView+Addons.h"

#define LOCAL_ZERO                  0
#define LOCAL_WINDOW_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define LOCAL_IS_IPHONE5            ((LOCAL_WINDOW_HEIGHT-568) ? NO : YES)
#define LOCAL_IPHONE5_OFFSET        88
#define LOCAL_IPHONE5_COEF          LOCAL_IS_IPHONE5 ? LOCAL_ZERO : LOCAL_IPHONE5_OFFSET
#define LOCAL_KEYBOARD_HEIGHT       216

@implementation UIView (Addons)

- (id)initWithResizeFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self resizeFrame];
    }
    return self;
}

- (void) resizeFrame
{
    CGRect rectSelf          = self.frame;
    rectSelf.size.height     = rectSelf.size.height-LOCAL_IPHONE5_COEF;
    [self setFrame:rectSelf];
}

- (void) resizeFrameForKeyboard:(BOOL)yesOrNo
{
    CGRect rectSelf          = self.frame;
    
    if (yesOrNo)
        rectSelf.size.height = rectSelf.size.height-LOCAL_KEYBOARD_HEIGHT;
    else
        rectSelf.size.height = rectSelf.size.height+LOCAL_KEYBOARD_HEIGHT;
    
    [self setFrame:rectSelf];
}

- (UIView *) findFirstResponder
{
    if (self.isFirstResponder)
        return self;
    // ...
    for (UIView *subView in self.subviews)
    {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil)
            return firstResponder;
    }
    // ...
    return nil;
}

@end
