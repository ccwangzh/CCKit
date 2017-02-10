//
//  CCKeychain.m
//  CCKit
//
//  Created by can on 17/2/10.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCKeychain.h"

@implementation CCKeychain
+ (instancetype)keychain {
    return [[self alloc] init];
}
@end

@interface CCSecItem ()
- (NSDictionary *)dictionary;
@end

@implementation CCSecItem
- (NSDictionary *)dictionary {
    return nil;
}
@end

@implementation CCSecPasswordItem

@end

@implementation CCSecGenericPasswordItem
- (OSStatus)secDelete {
    NSMutableDictionary *dictionary = (NSMutableDictionary *)[self dictionary];
    return SecItemDelete((__bridge CFDictionaryRef)dictionary);
}
- (OSStatus)secAddObject:(id)object {
    return [self secAddData:[NSKeyedArchiver archivedDataWithRootObject:object]];
}
- (OSStatus)secAddData:(NSData *)data {
    NSMutableDictionary *dictionary = (NSMutableDictionary *)[self dictionary];
    dictionary[(__bridge NSString *)kSecValueData] = data;
    return SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
}
- (OSStatus)secGetOneObject:(id *)objectRef {
    NSData *data = nil; __autoreleasing id object = nil;
    OSStatus status = [self secGetOneData:&data];
    if (!status && data) {
        @try {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } @catch (NSException *exception) {} @finally {}
    }
    if (object) *objectRef = object;
    return status;
}
- (OSStatus)secGetOneData:(NSData **)dataRef {
    NSMutableDictionary *dictionary = (NSMutableDictionary *)[self dictionary];
    dictionary[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    dictionary[(__bridge NSString *)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    CFDataRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dictionary, (CFTypeRef *)&result);
    *dataRef = (__bridge_transfer NSData *)result;
    return status;
}
- (NSDictionary *)dictionary {
    NSDictionary *superDictionary = [super dictionary];
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary addEntriesFromDictionary:superDictionary];
    dictionary[(__bridge NSString *)kSecAttrAccount] = self.account;
    dictionary[(__bridge NSString *)kSecAttrService] = self.service;
    dictionary[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassGenericPassword;
    return dictionary;
}
@end
