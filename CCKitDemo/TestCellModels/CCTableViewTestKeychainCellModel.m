//
//  CCTableViewTestKeychainCellModel.m
//  CCKit
//
//  Created by can on 17/2/10.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestKeychainCellModel.h"

#import "CCKeychain.h"

@implementation CCTableViewTestKeychainCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：钥匙串";
    }
    return self;
}

- (void)doTest {
    CCSecGenericPasswordItem *gpi = [CCSecGenericPasswordItem new];
    gpi.account = @"ccwangzh";
    OSStatus status = 0;
    
    id object = nil;
    status = [gpi secGetOneObject:&object];
    if (status == errSecSuccess && object) {
        NSLog(@"status:%d,%@", status, object);
        status = [gpi secDelete];
        NSLog(@"status:%d", status);
        NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    }
    object = @"1234567890-no-acc-no-srv";
    status = [gpi secAddObject:object];
    NSLog(@"status:%d", status);
    NSAssert(status == errSecSuccess, @"status != errSecSuccess");

    id result = nil;
    status = [gpi secGetOneObject:&result];
    NSLog(@"status:%d,%@", status, result);
    NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    NSAssert([result isEqualToString:object], @"status != errSecSuccess");
    
    status = [gpi secDelete];
    NSLog(@"status:%d", status);
    NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    
    result = nil;
    status = [gpi secGetOneObject:&result];
    NSLog(@"status:%d,%@", status, result);
    NSAssert(status != errSecSuccess, @"status == errSecSuccess");
}
@end
