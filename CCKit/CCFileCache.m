//
//  CCFileCache.m
//  CCKit
//
//  Created by can on 17/2/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCFileCache.h"

#import <CommonCrypto/CommonCrypto.h>

@interface CCFileCache ()
{
    NSString *_cachePath;
    dispatch_semaphore_t _lock;
}
@end

@implementation CCFileCache
+ (instancetype)fileCache {
    return [[self alloc] initWithPath:@"FileCaches"];
}

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [[paths firstObject] stringByAppendingPathComponent:path];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        BOOL isExists = [fileManager fileExistsAtPath:cachePath isDirectory:&isDirectory];
        if (!isExists) {
            [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:NULL error:NULL];
        }  else if (isExists && !isDirectory) {
            [fileManager removeItemAtPath:cachePath error:NULL];
            [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
        NSLog(@"cachePath:%@", cachePath);
        _cachePath = cachePath;
    }
    return self;
}

- (NSData *)dataForKey:(NSString *)key {
    if (key == nil) return nil;
    NSString *filePath = [self filePathForKey:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        return nil;
    }
    return [NSData dataWithContentsOfFile:filePath];
}

- (void)setData:(NSData *)data forKey:(NSString *)key {
    if (data == nil || key == nil) return;
    NSString *filePath = [self filePathForKey:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:NULL];
    }
    [data writeToFile:filePath options:NSDataWritingAtomic error:NULL];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    id object = nil;
    NSData *data = [self dataForKey:key];
    if (data && data.length > 0) {
        @try {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } @catch (NSException *exception) {} @finally {}
    }
    return object;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    if (object == nil || key == nil) return;
    NSData *data = nil;
    @try {
        data = [NSKeyedArchiver archivedDataWithRootObject:object];
    } @catch (NSException *exception) {} @finally {}
    if (data && data.length > 0) {
        [self setData:data forKey:key];
    }
}

- (void)removeObjectForKey:(NSString *)key {
    if (key == nil) return;
    NSString *filePath = [self filePathForKey:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:NULL];
    }
}

- (BOOL)containsObjectForKey:(NSString *)key {
    if (key == nil) return NO;
    NSString *filePath = [self filePathForKey:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

- (NSString *)filePathForKey:(NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) str = "";
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *hash = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return [_cachePath stringByAppendingPathComponent:hash];
}

@end
