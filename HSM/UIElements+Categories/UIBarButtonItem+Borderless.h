//
//  UIBarButtonItem+Borderless.h
//  T-APL
//
//  Created by Felipe Ricieri on 20/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Borderless)

- (id) initWithSelector:(SEL)selector andImage:(NSString*) image toTarget:(id)target;
- (UIButton*) newButton: (NSString*) image;

@end
