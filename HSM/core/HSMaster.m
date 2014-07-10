//
//  HSMaster.m
//  HSM
//
//  Created by Felipe Ricieri on 16/06/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "HSMaster.h"

@implementation HSMaster

@synthesize stringConverter;
@synthesize humamFormatter;

#pragma mark -
#pragma mark Shared Singleton
+ (HSMaster *) core {
    static HSMaster *singleton;
    @synchronized(self) {
        if (!singleton){
            singleton = [[HSMaster alloc] init];
			singleton.stringConverter = [[NSDateFormatter alloc] init];
			singleton.humamFormatter = [[NSDateFormatter alloc] init];
			// Setup
			[singleton.stringConverter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
			[singleton.humamFormatter setDateFormat:@"dd/MM"];
        }
        return singleton;
    }
}
+ (HSRestClient *) rest {
	static HSRestClient* rest;
	@synchronized(self){
		if(!rest){
			rest = [HSRestClient new];
            [rest loadInBackground:NO];
		}
		return rest;
	}
}

#pragma mark - Methods

- (NSArray*) nextEvents:(NSArray *) allEvents
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
    NSMutableArray *selected = [NSMutableArray array];
    
    NSDate *today = [NSDate date];
    for (NSDictionary *event in allEvents){
        BOOL canAdd = NO;
        for (NSString *dateStr in [[event objectForKey:@"info"] objectForKey:@"dates"]) {
			NSDate *date = [df dateFromString:dateStr];
            if ([today compare:date] == NSOrderedSame
				||  [today compare:date] == NSOrderedAscending){
                canAdd = YES;
                break;
            }
        }
        if (canAdd)
            [selected addObject:event];
    }
    
    return [selected copy];
}
- (NSArray*) previousEvents:(NSArray *) allEvents
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
    NSMutableArray *selected = [NSMutableArray array];
    
    NSDate *today = [NSDate date];
    for (NSDictionary *event in allEvents){
        BOOL canAdd = NO;
        for (NSString *dateStr in [[event objectForKey:@"info"] objectForKey:@"dates"]) {
			NSDate *date = [df dateFromString:dateStr];
            if ([today compare:date] == NSOrderedDescending){
                canAdd = YES;
                break;
            }
        }
        if (canAdd)
            [selected addObject:event];
    }
    
    return [selected copy];
}
- (NSDictionary *) events:(NSArray *) allEvents forId:(NSString *) eventId
{
    NSDictionary *event = nil;
    for (NSDictionary *eventSingle in allEvents)
        if ([[event objectForKey:@"id"] isEqualToString:eventId])
            event = eventSingle;
    
    return event;
}
- (BOOL) eventDidHappen:(NSDictionary *) event
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
    NSDate *today = [NSDate date];
	BOOL canAdd = NO;
	
    for (NSString *dateStr in [event objectForKey:@"dates"]) {
		NSDate *date = [df dateFromString:dateStr];
		if ([date compare:today] == NSOrderedAscending){
			canAdd = YES;
			break;
		}
	}
    return canAdd;
}

// agenda

- (NSMutableArray *) agenda:(NSArray *) agenda splitedByDays:(NSArray *) dates
{
    // for each day...
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
    NSMutableArray *splitedArray = [NSMutableArray array];
    for (NSString *dateStr in dates) {
		NSDate *date = [df dateFromString:dateStr];
        NSMutableArray *agendaArray = [NSMutableArray array];
        // search at agenda array..
        for (NSDictionary *lecture in agenda) {
			NSDate *dateLecture = [df dateFromString:[[lecture objectForKey:@"date"] objectForKey:@"date"]];
            if ([dateLecture compare:date] == NSOrderedSame) {
                [agendaArray addObject:lecture];
            }
        }
        [splitedArray addObject:agendaArray];
    }
    return [splitedArray copy];
}

@end
