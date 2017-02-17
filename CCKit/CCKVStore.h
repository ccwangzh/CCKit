//
//  CCKVStore.h
//  CCKit
//
//  Created by can on 17/2/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCKVStore : NSObject
+ (instancetype)store;
- (instancetype)initWithName:(NSString *)name;

- (void)setObject:(NSString *)object forKey:(NSString *)key;
- (NSString *)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (BOOL)containsObjectForKey:(NSString *)key;

@end
