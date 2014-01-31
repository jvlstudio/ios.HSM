//
//  FRTools.h
//  T-APL
//
//  Created by Felipe Ricieri on 11/09/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

/* typedef */

typedef enum AlertViewOptions : NSUInteger
{
    kOptionNo   = 0,
    kOptionYes  = 1
}
AlertViewOptions;

/* protocol */

@protocol FRicieriToolsDelegate <NSObject>

@optional

- (void) dialogDidRespondYes;
- (void) dialogDidRespondNo;

@end

/* interface */

@interface FRTools : NSObject <UIAlertViewDelegate, NSURLConnectionDataDelegate>
{
    SystemSoundID audioEffect;
}

@property (nonatomic, copy) void (^frCompYes)(void);
@property (nonatomic, copy) void (^frCompNo)(void);

#pragma mark -
#pragma mark Start Methods

- (id) initWithTools;
- (id) initWithtoolsAndRootViewController:(UIViewController*) parent;

/*********************
 * FR > plists
 *********************/

#pragma mark -
#pragma mark Methods

- (id)   propertyListRead:(NSString*) plistName;
- (BOOL) propertyListWrite:(id) content forFileName:(NSString*) fileName;

/*********************
 * FR > methods
 *********************/

#pragma mark -
#pragma mark String Methods

- (NSArray*) explode: (NSString*) string bySeparator:(NSString*)separator;
- (BOOL)     compare: (NSString*) string1 with:(NSString*) string2;

#pragma mark -
#pragma mark AudioToolbox Methods

- (void) soundWithFileName: (NSString *) fName ofType:(NSString *) ext;

/*********************
 * FR > update
 *********************/

@property (nonatomic, strong) NSString *upData;
@property (nonatomic, strong) NSString *updateLastKey;
@property (nonatomic, strong) NSDictionary *JSONData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) UIViewController *parentViewController;

#pragma mark -
#pragma mark Sync Methods

- (void) sync: (NSString *) message;
- (void) sync: (NSString *) message success:(void(^)(void))callback;
- (void) syncStart: (NSString *) message;
- (void) syncHandle: (NSString *) message;
- (void) syncEnd: (NSString *) message;
- (void) syncError: (NSString *) message;

#pragma mark -
#pragma mark Request Methods

- (NSString*) URLEncode: (NSString*) string;
- (NSURLRequest*) URLAsRequest: (NSString*) url;
- (NSString*) paramsForRequestWithDictionary:(NSDictionary*)dict;

- (void) requestUpdateFrom:(NSString*) strURL success:(void(^)(void))callback;
- (void) requestUpdateFrom:(NSString*) strURL success:(void(^)(void))callback fail:(void(^)(void))finished;

#pragma mark -
#pragma mark Download Methods

- (void) downloadDataFrom:(NSString*) strURL success:(void(^)(void))callback;
- (void) downloadDataFrom:(NSString*) strURL success:(void(^)(void))callback fail:(void(^)(void))finished;

/*********************
 * FR > views
 *********************/

#pragma mark -
#pragma mark Methods

- (void) viewWithDropShadow:(UIView*) view;
- (void) touchViewToHideKeyboard: (id) selfselector forView: (UIView*) view withSelector: (SEL)selector;
- (void) listOfFontsAndFamilies;

/*********************
 * FR > dialog
 *********************/

@property (nonatomic, strong) UIAlertView *frdialog;

#pragma mark -
#pragma mark Methods

- (void) dialogWithMessage:(NSString*) message;
- (void) dialogWithMessage:(NSString*) message cancelButton:(NSString*) cancel;
- (void) dialogWithMessage:(NSString*) message title:(NSString*) title;
- (void) dialogWithMessage:(NSString*) message cancelButton:(NSString*) cancel title:(NSString*) title;
- (void) promptWithMessage:(NSString*) message competitionYes:(void(^)(void)) compYes competitionNo:(void(^)(void)) compNo;

/*********************
 * FR > images
 *********************/

#pragma mark -
#pragma mark Upload Methods

- (void) upload:(UIImage*) image;
- (void) upload:(UIImage*) image parameters:(NSArray*) params;
- (void) upload:(UIImage*) image parameters:(NSArray*) params toURL:(NSString*) url;

#pragma mark -
#pragma mark Upload Methods

- (UIImage *) captureScreen;
- (NSData*)   imageFromURL: (NSString*) URLString;

/*********************
 * FR > validate
 *********************/

#pragma mark -
#pragma mark Methods

- (BOOL) isValidEmail:(NSString*) str;
- (BOOL) isValidCPF:(NSString*) str;
- (BOOL) isValidCNPJ:(NSString*) str;

/*********************
 * FR > errors
 *********************/

#pragma mark -
#pragma mark Methods

- (void) errorWithData:(NSData*) data withRecipient:(NSString*) recipt;
- (id)   errorWithJSON:(NSString*) retData withSelector:(SEL) finishSelector;
- (void) errorWithError:(NSError*) error;

@end
