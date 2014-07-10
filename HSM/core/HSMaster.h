//
//  HSMaster.h
//  HSM
//
//  Created by Felipe Ricieri on 16/06/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSRestClient.h"

#pragma mark - Interface

@interface HSMaster : NSObject

// Singletons
+ (HSMaster *) core;
+ (HSRestClient *) rest;

// Properties
@property (nonatomic, strong) NSDateFormatter *stringConverter;
@property (nonatomic, strong) NSDateFormatter *humamFormatter;

#pragma mark - Methods

- (NSArray*) nextEvents:(NSArray *) allEvents;
- (NSArray*) previousEvents:(NSArray *) allEvents;
- (NSDictionary *) events:(NSArray *) allEvents forId:(NSString *) eventId;
- (BOOL) eventDidHappen:(NSDictionary *) event;

- (NSMutableArray *) agenda:(NSArray *) agenda splitedByDays:(NSArray *) dates;

@end
