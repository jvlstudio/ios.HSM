//
//  NetworkViewController.h
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"
#import <AddressBook/AddressBook.h>

@interface NetworkViewController : KDViewController

#pragma mark -
#pragma mark Common Methods

- (BOOL) isContactAlreadyAdded:(NSString*) email;

- (void) saveContact:(NSDictionary*) dict;
- (void) setContactAsAdded:(NSString*) email;
- (BOOL) hasContactBeenAdd:(NSString*) email;
- (void) setSelfCard:(NSDictionary*) dict;
- (BOOL) hasCreatedSelfCard;

- (BOOL) isValidQRCode:(NSString*) qrcode;
- (NSString*) QRCodeEncrypt:(NSDictionary*) dict;
- (NSDictionary*) QRCodeDecrypt:(NSString*) string;

- (BOOL) addContactToAddressBook:(NSDictionary*) dict;

@end
