//
//  NSString+CCAddition.m
//  CCKit
//
//  Created by can on 1/7/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import "NSString+CCAddition.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (CCAddition)
- (BOOL)match:(NSString *)regular
{
    return [self rangeOfString:regular options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])].length > 0;
}
- (BOOL)isDigit
{
    return [self match:@"^[0-9]*$"];
}
- (BOOL)isPhone
{
    return [self match:@"^1[3|4|5|7|8][0-9]{9}$"];
}
- (BOOL)isEmail
{
    return [self match:@"^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$"];
}

- (NSString *)md5Value;
{
    const char *str = self.UTF8String;
    if (str == NULL) str = "";
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];

}
- (NSString *)sha1Value
{
    const char *str = self.UTF8String;
    if (str == NULL) str = "";
    unsigned char r[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15], r[16], r[17], r[18], r[19]];
}
- (NSString *)sha256Value
{
    const char *str = self.UTF8String;
    if (str == NULL) str = "";
    unsigned char r[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15], r[16], r[17], r[18], r[19], r[20], r[21], r[22], r[23], r[24], r[25], r[26], r[27], r[28], r[29], r[30], r[31]];
}
@end
