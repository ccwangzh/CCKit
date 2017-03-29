//
//  CCFileCache.h
//  CCKit
//
//  Created by can on 17/2/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFileCache : NSObject
+ (instancetype)fileCache;
- (instancetype)initWithPath:(NSString *)path;

- (NSData *)dataForKey:(NSString *)key ;
- (void)setData:(NSData *)data forKey:(NSString *)key;

- (id<NSCoding>)objectForKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (BOOL)containsObjectForKey:(NSString *)key;
@end
