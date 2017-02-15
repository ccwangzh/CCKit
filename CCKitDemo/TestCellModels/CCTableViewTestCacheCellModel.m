//
//  CCTableViewTestCacheCellModel.m
//  CCKit
//
//  Created by can on 17/2/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCacheCellModel.h"

#import "CCFileCache.h"

@interface CCTableViewTestCacheCellModel ()
{
    CCFileCache *_cache;
}
@end

@implementation CCTableViewTestCacheCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：缓存";
        _cache = [CCFileCache fileCache];
    }
    return self;
}

- (void)doTest {
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
@end
