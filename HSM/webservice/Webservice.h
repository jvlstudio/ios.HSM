//
//  Webservice.h
//  HSM
//
//  Created by Felipe Ricieri on 25/02/14.
//  Copyright (c) 2014 ikomm Digital Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Webservice : NSObject
{
    NSString *httpData;
    NSDictionary *restData;
}

@property (nonatomic, strong) NSString *httpData;
@property (nonatomic, strong) NSDictionary *restData;

@end
