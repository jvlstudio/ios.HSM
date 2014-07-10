//
//  Webservice.m
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import "Webservice.h"
#import "FRTools.h"

#pragma mark - Interface

@interface Webservice ()
//- (id) sendHTTPRequestToURL:(NSString*) urlName data:(NSDictionary*) data completion:(void(^)(void)) completion;
@end

#pragma mark - Implementation

@implementation Webservice
{
    FRTools *tools;
}

@synthesize httpData;
@synthesize restData;

#pragma mark -
#pragma mark Init Methods

- (id) initWithAPI
{
	tools	= [[FRTools alloc] initWithTools];
	return self;
}
- (void) setCanShowErrors:(BOOL) canShow
{
	//[tools setCanShowErrorAlerts:canShow];
}

#pragma mark - Methods


#pragma mark - Private Methods



@end
