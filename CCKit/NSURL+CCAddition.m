//
//  NSURL+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/6.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "NSURL+CCAddition.h"

@implementation NSURL (CCAddition)
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString
{
    if (!queryString || queryString.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"%@://%@", self.scheme, self.host];
    if (self.port) {
        [string appendFormat:@":%@", self.port];
    }
    if (self.path) {
        [string appendFormat:@"%@", self.path];
    }
    if (self.parameterString) {
        [string appendFormat:@";%@", self.parameterString];
    }
    [string appendString:@"?"];
    if (self.query) {
        [string appendFormat:@"%@&", self.query];
    }
    [string appendFormat:@"%@", queryString];
    if (self.fragment) {
        [string appendFormat:@"#%@", self.fragment];
    }
    return [NSURL URLWithString:string] ? : self;
}
@end
