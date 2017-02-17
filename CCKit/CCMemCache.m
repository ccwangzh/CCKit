//
//  CCMemCache.m
//  CCKit
//
//  Created by can on 17/2/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCMemCache.h"

@interface CCMemCache ()
{
    NSMutableDictionary *_dict;
}
@end

@implementation CCMemCache
+ (instancetype)cache {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _dict = [NSMutableDictionary new];
    }
    return self;
}

- (NSUInteger)count {
    return [_dict count];
}

- (id)objectForKey:(id <NSCopying>)aKey {
    return [_dict objectForKey:aKey];
}

- (void)removeObjectForKey:(id <NSCopying>)aKey{
    [_dict removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    [_dict setObject:anObject forKey:aKey];
}

@end
