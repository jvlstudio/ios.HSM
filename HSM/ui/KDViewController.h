//
//  KDViewController.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Advertising.h"

@interface KDViewController : UIViewController

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UIImageView *imgBackgroundBlur;
@property (nonatomic, strong) UIImage *imgBackgroundNavBar;
@property (nonatomic, strong) UIView *edge;

#pragma mark -
#pragma mark Init Methods

- (id) initWithNibName:(NSString*) nibName andDictionary:(NSDictionary*) dict;
- (id) initWithNibName:(NSString*) nibName andArray:(NSArray*) arr;
- (id) initWithNibName:(NSString*) nibName andArray:(NSArray*) arr andDictionary:(NSDictionary*) dict;

#pragma mark -
#pragma mark ViewController Methods

- (void) viewDidLoadWithMenuButton;
- (void) viewDidLoadWithBackButton;
- (void) viewDidLoadWithCloseButton;
- (void) viewDidLoadWithNothing;

#pragma mark -
#pragma mark BarButton Methods

- (void) setMenuButton;
- (void) setBackButton;
- (void) setCloseButton;
- (void) setScanButtonWithSelector:(SEL)select;
- (void) setNothing;

#pragma mark -
#pragma mark IBAction Methods

- (void) pressMenuButton:(id)sender;
- (void) pressBackButton:(id)sender;
- (void) pressCloseButton:(id)sender;

#pragma mark -
#pragma mark Side Menu Methods

- (void) preloadLeft;
- (void) showLeft;

@end
