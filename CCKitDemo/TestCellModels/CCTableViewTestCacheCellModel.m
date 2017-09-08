//
//  CCTableViewTestCacheCellModel.m
//  CCKit
//
//  Created by can on 17/2/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCacheCellModel.h"

#import "CCKVStore.h"
#import "CCMemCache.h"
#import "CCFileCache.h"


@interface CCTableViewTestCacheCellModel ()
{
    CCFileCache *_cache;
    CCMemCache *_memory;
    CCKVStore *_store;
}
@end

@implementation CCTableViewTestCacheCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：缓存";
        _cache = [CCFileCache fileCache];
        _memory = [CCMemCache cache];
        _store = [CCKVStore store];
    }
    return self;
}

- (void)testMemCache {
    NSString *key = @"name"; NSString *value = @"ccwangzh";
    [_memory setObject:value forKey:key];
    NSString *newValue = [_memory objectForKey:key];
    NSLog(@"newValue:%@", newValue);
    [_memory removeObjectForKey:key];
}

- (void)testKVStore {
    NSString *key = @"name"; NSString *value = @"ccwangzh";
    NSString *key1 = @"name1"; NSString *value1 = @"ccwangzh1";
    [_store setObject:value forKey:key];
    BOOL contains = [_store containsObjectForKey:key];
    if (contains) {
        NSString *newValue = [_store objectForKey:key];
        NSLog(@"newValue:%@", newValue);
        
        [_store setObject:value1 forKey:key];
        newValue = [_store objectForKey:key];
        NSLog(@"newValue1:%@", newValue);
        
        [_store setObject:value1 forKey:key1];
        newValue = [_store objectForKey:key1];
        NSLog(@"newValue1:%@", newValue);
        
        [_store removeObjectForKey:key];
        [_store removeObjectForKey:key1];
        
        contains = [_store containsObjectForKey:key];
        NSLog(@"contains:%d", contains);
        
        contains = [_store containsObjectForKey:key1];
        NSLog(@"contains1:%d", contains);
    }
}

- (void)testFileCache {
    NSString *dateString = [[NSDate new] description];
    NSData *data = [dateString dataUsingEncoding:NSUTF8StringEncoding];
    [_cache setData:data forKey:@"date"];
    NSLog(@"1data:%@", data);
    
    BOOL isExists = [_cache containsObjectForKey:@"date"];
    NSLog(@"1isExists:%d", isExists);
    if (isExists) {
        data = [_cache dataForKey:@"date"];
        if (data) {
            NSLog(@"2data:%@", data);
            [_cache removeObjectForKey:@"date"];
        }
        isExists = [_cache containsObjectForKey:@"date"];
        NSLog(@"2isExists:%d", isExists);
    }
    
    NSDate *date = [NSDate new];
    [_cache setObject:date forKey:@"object"];
    isExists = [_cache containsObjectForKey:@"object"];
    if (isExists) {
        date = (NSDate *)[_cache objectForKey:@"object"];
        NSLog(@"date:%@", date);
        [_cache removeObjectForKey:@"object"];
        isExists = [_cache containsObjectForKey:@"object"];
        NSLog(@"2isExists:%d", isExists);
    }
}

- (void)testArchive {
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:1487217646];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:1487217646];
    NSLog(@"%@,%@,%p,%p", date1, date2, &date1, &date2);
    
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:date1];
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:date2];
    NSLog(@"%@", data1);
    NSLog(@"%@", data2);
}

- (void)doTest {

    [self testMemCache];
}


@end
