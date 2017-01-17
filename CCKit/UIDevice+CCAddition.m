//
//  UIDevice+CCAddition.m
//  CCKit
//
//  Created by can on 1/7/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import "UIDevice+CCAddition.h"

@implementation UIDevice (CCAddition)
- (NSString *)identifierForApplication
{
    static NSString *_idfa = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *storeKey = @"identifierForApplication";
        NSDictionary *info = [NSBundle mainBundle].infoDictionary;
        NSString *bundleId = info[@"CFBundleIdentifier"];
        NSMutableDictionary *query = [NSMutableDictionary dictionary];
        query[(__bridge NSString *)kSecAttrService] = bundleId;
        query[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassGenericPassword;
        query[(__bridge NSString *)kSecAttrAccount] = [storeKey description];
        
        query[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
        query[(__bridge NSString *)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
        
        CFDataRef result = NULL;
        if (SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result) == errSecSuccess) {
            @try {
                _idfa = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)result];
            } @catch (NSException *exception) {} @finally {}
        }
        if (_idfa == nil || ![_idfa isKindOfClass:[NSString class]] || _idfa.length == 0) {
            CFUUIDRef uuidRef = CFUUIDCreate(NULL);
            CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
            _idfa = (__bridge_transfer NSString *)uuidStrRef;
            if (uuidRef) CFRelease(uuidRef);
            
            query = [NSMutableDictionary dictionary];
            query[(__bridge NSString *)kSecAttrService] = bundleId;
            query[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassGenericPassword;
            query[(__bridge NSString *)kSecAttrAccount] = [storeKey description];
            
            query[(__bridge NSString *)kSecValueData] =  [NSKeyedArchiver archivedDataWithRootObject:_idfa];
            
            SecItemDelete((__bridge CFDictionaryRef)query);
            SecItemAdd((__bridge CFDictionaryRef)query, NULL);
        }
    });
    return _idfa;
}
@end
