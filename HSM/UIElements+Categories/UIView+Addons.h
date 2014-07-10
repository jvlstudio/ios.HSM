//
//  UIView+Addons.h
//  T-APL
//
//  Created by Felipe Ricieri on 22/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addons)

- (id) initWithResizeFrame:(CGRect) frame;

- (void) resizeFrame;
- (void) resizeFrameForKeyboard:(BOOL) yesOrNo;

- (UIView *) findFirstResponder;

@end
