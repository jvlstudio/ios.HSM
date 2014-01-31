//
//  AppDelegate.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Home;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Home *viewController;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;

#pragma mark -
#pragma mark Opening Methods

- (UIViewController*) openingWithAnimation;
- (UIViewController*) openingWithoutAnimation;

@end
