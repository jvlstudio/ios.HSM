//
//  NSString+Slug.m
//  T-APL
//
//  Created by Felipe Ricieri on 29/08/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NSString+Slug.h"

@implementation NSString (Slug)

- (NSString *) slug
{
    NSString *slug = [self lowercaseString];
    [slug stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return slug;
}

@end
