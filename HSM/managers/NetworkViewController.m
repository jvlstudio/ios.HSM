//
//  NetworkViewController.m
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NetworkViewController.h"

#define LOG_AB_ADDED    @"AbAdded"
#define QRCODE_KEYS     @[KEY_NAME, KEY_EMAIL, KEY_PHONE, KEY_MOBILE, KEY_COMPANY, KEY_ROLE, KEY_WEBSITE, KEY_BARCOLOR]

@interface NetworkViewController ()

@end

@implementation NetworkViewController
{
    FRTools *tools;
}

#pragma mark -
#pragma mark Controller Methods

- (void) viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewDidLoadWithBackButton
{
    [super viewDidLoadWithBackButton];
}

#pragma mark -
#pragma mark Common Methods

- (BOOL) isContactAlreadyAdded:(NSString*) email
{
    tools           = [[FRTools alloc] initWithTools];
    NSArray *arr    = [tools propertyListRead:PLIST_NETWORK];
    
    for (NSDictionary *dict in arr)
        if ([[dict objectForKey:KEY_EMAIL] isEqualToString:email])
            return YES;
    
    return NO;
}

- (void) saveContact:(NSDictionary *)dict
{
    tools           = [[FRTools alloc] initWithTools];
    NSMutableArray *network = [tools propertyListRead:PLIST_NETWORK];
    [network addObject:dict];
    [tools propertyListWrite:network forFileName:PLIST_NETWORK];
}
- (void) setContactAsAdded:(NSString*) email
{
    tools           = [[FRTools alloc] initWithTools];
    NSMutableDictionary *logs = [tools propertyListRead:PLIST_LOGS];
    NSString *logKey    = [NSString stringWithFormat:@"%@_%@", LOG_AB_ADDED, email];
    [logs setObject:KEY_YES forKey:logKey];
    [tools propertyListWrite:logs forFileName:PLIST_LOGS];
}
- (BOOL) hasContactBeenAdd:(NSString *)email
{
    tools           = [[FRTools alloc] initWithTools];
    NSDictionary *logs  = [tools propertyListRead:PLIST_LOGS];
    NSString *logKey    = [NSString stringWithFormat:@"%@_%@", LOG_AB_ADDED, email];
    
    if ([[logs objectForKey:logKey] isEqualToString:KEY_YES])
        return YES;
    else
        return NO;
}

- (void) setSelfCard:(NSDictionary *)dict
{
    tools           = [[FRTools alloc] initWithTools];
    [tools propertyListWrite:dict forFileName:PLIST_MYCONTACT];
}
- (BOOL) hasCreatedSelfCard
{
    tools           = [[FRTools alloc] initWithTools];
    NSDictionary *logs  = [tools propertyListRead:PLIST_MYCONTACT];
    
    if ([logs count] > 0)
        return YES;
    else
        return NO;
}

- (BOOL)isValidQRCode:(NSString *)qrcode
{
    tools        = [[FRTools alloc] initWithTools];
    NSArray *arr = [tools explode:qrcode bySeparator:KEY_EXPLODE];
    
    if ([arr count] == [QRCODE_KEYS count])
        return YES;
    else
        return NO;
}
- (NSString *) QRCodeEncrypt:(NSDictionary *)dict
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *key in QRCODE_KEYS)
        [arr addObject:[dict objectForKey:key]];
    
    /*
    [arr addObject:[dict objectForKey:KEY_NAME]];
    [arr addObject:[dict objectForKey:KEY_EMAIL]];
    [arr addObject:[dict objectForKey:KEY_PHONE]];
    [arr addObject:[dict objectForKey:KEY_MOBILE]];
    [arr addObject:[dict objectForKey:KEY_COMPANY]];
    [arr addObject:[dict objectForKey:KEY_ROLE]];
    [arr addObject:[dict objectForKey:KEY_WEBSITE]];
    [arr addObject:[dict objectForKey:KEY_BARCOLOR]];*/
    
    NSString *strRet = [arr componentsJoinedByString:KEY_EXPLODE];
    strRet           = [strRet stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", strRet);
    return strRet;
}
- (NSDictionary *) QRCodeDecrypt:(NSString *)string
{
    tools        = [[FRTools alloc] initWithTools];
    NSArray *arr = [tools explode:string bySeparator:KEY_EXPLODE];
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    
    for (uint i=0; i<[arr count]; i++)
        [mutDict setObject:[arr objectAtIndex:i] forKey:[QRCODE_KEYS objectAtIndex:i]];
    
    NSLog(@"%@", mutDict);
    return [mutDict copy];
}

- (BOOL) addContactToAddressBook:(NSDictionary*) dict
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    __block BOOL accessGranted   = NO;
    BOOL didAdd = NO;
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        accessGranted = granted;
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    // can add..
    if (accessGranted)
    {
        NSString *obs       = @"Contato adicionado via cartão virtual da HSM Inspiring Ideas, desenvolvido pela ikomm Digital Solutions.";
        
        // (0) firstname + (1) lastname + (2) company + (3) email + (4) phone
        ABRecordRef person = ABPersonCreate();
        CFErrorRef  error = NULL;
        
        // firstname
        ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFTypeRef)([dict objectForKey:KEY_NAME]), NULL);
        
        // company, role
        ABRecordSetValue(person, kABPersonOrganizationProperty, (__bridge CFTypeRef)([dict objectForKey:KEY_COMPANY]), NULL);
        ABRecordSetValue(person, kABPersonJobTitleProperty, (__bridge CFTypeRef)([dict objectForKey:KEY_ROLE]), NULL);
        
        // email
        ABMutableMultiValueRef abEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(abEmail, (__bridge CFTypeRef)([dict objectForKey:KEY_EMAIL]), CFSTR("email"), NULL);
        ABRecordSetValue(person, kABPersonEmailProperty, abEmail, &error);
        CFRelease(abEmail);
        
        // phone
        ABMutableMultiValueRef abPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(abPhone, (__bridge CFTypeRef)([dict objectForKey:KEY_PHONE]), CFSTR("telefone (HSM)"), NULL);
        ABMultiValueAddValueAndLabel(abPhone, (__bridge CFTypeRef)([dict objectForKey:KEY_MOBILE]), CFSTR("celular (HSM)"), NULL);
        ABRecordSetValue(person, kABPersonPhoneProperty, abPhone, &error);
        CFRelease(abPhone);
        
        // note
        ABRecordSetValue(person, kABPersonNoteProperty, (__bridge CFTypeRef)(obs), NULL);
        
        /*
         // add an image !
         UIImage *im = [UIImage imageNamed:@"logo_mobile_48.png"];
         NSData *dataRef = UIImagePNGRepresentation(im);
         ABPersonSetImageData(newPerson, (__bridge CFDataRef)dataRef, nil);*/
        
        ABAddressBookAddRecord(addressBook, person, nil);
        didAdd = ABAddressBookSave(addressBook, nil);
        
        CFRelease(person);
    }
    
    return didAdd;
}

@end
