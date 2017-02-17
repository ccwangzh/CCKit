//
//  CCMemCache.h
//  CCKit
//
//  Created by can on 17/2/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMemCache : NSObject
@property (readonly) NSUInteger count;

+ (instancetype)cache;

- (id)objectForKey:(id <NSCopying>)aKey;

- (void)removeObjectForKey:(id <NSCopying>)aKey;

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
