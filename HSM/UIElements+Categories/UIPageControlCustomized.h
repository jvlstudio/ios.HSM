//
//  UIPageControlCustomized.h
//  T-APL
//
//  Created by Felipe Ricieri on 20/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPageControlCustomized : UIPageControl
{
    UIImage *activeImage;
    UIImage *inactiveImage;
}

#pragma mark -
#pragma mark Custom Methods

- (void) configureBullets:(NSString*) actived : (NSString*) disactived;

@end
