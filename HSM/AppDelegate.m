//
//  AppDelegate.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "AppDelegate.h"

#import "HSMAd.h"
#import "Opening.h"
#import "Home.h"

#pragma mark - Category

@interface UINavigationController (White)
@end
@implementation UINavigationController (White)
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end

#pragma mark - Implementation

@implementation AppDelegate
{
    HSMAd *adManager;
}

@synthesize revealSideViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = PP_AUTORELEASE([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
    
    // Let the device know we want to receive push notifications
    [Parse setApplicationId:PARSE_APP_ID
                  clientKey:PARSE_APP_SECRET];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
	[application registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
	// local notifications..
    [application cancelAllLocalNotifications];
    
    // Clear application badge when app launches
    application.applicationIconBadgeNumber = 0;
    
    // reveal slide view controller didn't work with this below
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    adManager = [[HSMAd alloc] initWithManager];
    if ([adManager hasAdWithCategory:kAdSuperstitial]) {
        self.window.rootViewController = [self openingWithAnimation];
    }
    else {
        self.window.rootViewController = [self openingWithoutAnimation];
    }
    
    [self.window makeKeyAndVisible];
    
    // ...
    [self customizeAppearance];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // return..
    return YES;
}

#pragma mark -
#pragma mark Opening Methods

- (UIViewController*) openingWithAnimation
{
    Opening *opening = [[Opening alloc] initWithNibName:NIB_OPENING bundle:nil];
    return opening;
}
- (UIViewController*) openingWithoutAnimation
{
    // Override point for customization after application launch.
    // RevealSlideController..
    self.viewController         = [[Home alloc] initWithNibName:NIB_HOME bundle:nil];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    revealSideViewController    = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
    revealSideViewController.delegate = self;
    
    return revealSideViewController;
}

#pragma mark -
#pragma mark UIDevice Methods

- (BOOL)checkIsDeviceVersionHigherThanRequiredVersion:(NSString *)requiredVersion
{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    if ([currSysVer compare:requiredVersion options:NSNumericSearch] != NSOrderedAscending)
        return YES;
    
    return NO;
}

- (void) customizeAppearance
{
	// Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      NSForegroundColorAttributeName,
      [[NSShadow alloc] shadowBlurRadius],
      NSShadowAttributeName,
      [UIFont fontWithName:FONT_BOLD size:26.0],
      NSFontAttributeName,
      nil]];
}

#pragma mark -
#pragma mark APNS Configuration

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"Local Notification: App está ativo.");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    [PFPush storeDeviceToken:devToken]; // Send parse the device token
    // Subscribe this user to the broadcast channel, ""
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully subscribed to the broadcast channel.");
        } else {
            NSLog(@"Failed to subscribe to the broadcast channel.");
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#if !TARGET_IPHONE_SIMULATOR
	NSLog(@"Error in registration. Error: %@", error);
#endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

@end
