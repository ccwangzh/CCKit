//
//  CCTableViewTestNetworkingCellModel.m
//  CCKit
//
//  Created by can on 17/2/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestNetworkingCellModel.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation CCTableViewTestNetworkingCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：网络";
    }
    return self;
}

- (void)doTest {
    CCTimeRequest *request = [CCTimeRequest new];
    [[CCApiClient apiClient] sendRequest:request completionHandler:^(CCHttpResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error:%@", error);
        } else {
            NSLog(@"response:%d,%@,%ld,%@", response.success, response.message, response.resultCode, response.results);
        }
    }];
}
@end

@implementation CCTimeRequest
- (NSString *)requestUrl {
    return @"http://jr-api.vip.com/common/now_time/v1";
}
- (NSString *)t {
    return @"0";
}
- (Class)responseClass {
    return [CCTimeResponse class];
}
@end

@implementation CCVIPApiRequest
- (NSString *)reqTime {
    return [NSString stringWithFormat:@"%ld", (long)(NSDate.date.timeIntervalSince1970)];
}
- (NSString *)device {
    return @"ios";
}
- (NSString *)mid {
    return @"419f11987313ee6afc33ea750f9686c554bae086";
}
- (NSString *)apiKey {
    return @"b11731399a584063be7a2ddeffc5d5ea";
}
- (NSString *)app_version {
    return @"1.1.0";
}
- (Class)responseClass {
    return [CCVIPApiResponse class];
}
- (id)requestHeaders {
    NSDictionary *parameters = [self requestParameters];
    NSString *apiSign = VFApiSign(parameters, @"6b3fbd498e9b40c6924b6c6660f6fe60" , nil);
    apiSign = [@"OAuth sign=" stringByAppendingString:apiSign];
    return @{@"Authorization": apiSign};
}
@end

@implementation CCVIPApiResponse
@end

@implementation CCHttpResponse (CCVIPApiResponse)
- (BOOL)success {return NO;};
- (NSString *)message {return nil;}
- (NSInteger)resultCode{return 0;}
- (id)results {return nil;};
@end

@implementation CCTimeResponse
@dynamic results;
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"results" : [CCTimeResult class]};
}
@end

@implementation CCTimeResult

@end

NSString *VFApiSign(NSDictionary *parameters, NSString *clientSecret, NSString *userSecret) {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray *sortedKeys = [[parameters allKeys] sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableString *sortedString = [NSMutableString string];
    for (id key in sortedKeys) {
        NSObject *value = parameters[key];
        if ([value isKindOfClass:NSString.class]) {
            [sortedString appendFormat:@"%@",  value];
        } else if ([value isKindOfClass:NSNumber.class]) {
            [sortedString appendFormat:@"%@", [(NSNumber *)value stringValue]];
        }
    }
    
    [sortedString appendString:clientSecret];
    
    if (userSecret && userSecret.length) {
        [sortedString appendFormat:@"&%@", userSecret];
    }
    
    const char *str = sortedString.UTF8String;
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5Str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5Str;
}
