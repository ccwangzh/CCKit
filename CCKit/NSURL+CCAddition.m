//
//  NSURL+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/6.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "NSURL+CCAddition.h"

@implementation NSURL (CCAddition)
- (NSURL *)URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary {
    if (!queryDictionary || queryDictionary.count == 0) return self;
    NSURLComponents *comp = [NSURLComponents componentsWithURL:self
                                       resolvingAgainstBaseURL:YES];
    NSArray *allKeys = [queryDictionary allKeys];
    NSMutableArray *queryItems = [NSMutableArray new];
    [queryItems addObjectsFromArray:[comp queryItems]];
    for (NSInteger j = 0; j < allKeys.count; j ++) {
        NSInteger oldQueryItemIndex = NSNotFound;
        NSString *key = [allKeys[j] description];
        NSString *value = [queryDictionary[key] description];
        for (NSInteger i = 0; i < queryItems.count; i ++) {
            NSURLQueryItem *queryItem = queryItems[i];
            if ([queryItem.name isEqualToString:key]) {
                oldQueryItemIndex = i;
                break;
            }
        }
        if (oldQueryItemIndex == NSNotFound) {
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:value]];
        }
    }
    comp.queryItems = queryItems;
    return comp.URL;
}

- (NSURL *)URLByReplacingQueryDictionary:(NSDictionary *)queryDictionary {
    if (!queryDictionary || queryDictionary.count == 0) return self;
    NSURLComponents *comp = [NSURLComponents componentsWithURL:self
                                       resolvingAgainstBaseURL:YES];
    NSArray *allKeys = [queryDictionary allKeys];
    NSMutableArray *queryItems = [NSMutableArray new];
    [queryItems addObjectsFromArray:[comp queryItems]];
    for (NSInteger j = 0; j < allKeys.count; j ++) {
        NSInteger oldQueryItemIndex = NSNotFound;
        NSString *key = [allKeys[j] description];
        NSString *value = [queryDictionary[key] description];
        for (NSInteger i = 0; i < queryItems.count; i ++) {
            NSURLQueryItem *queryItem = queryItems[i];
            if ([queryItem.name isEqualToString:key]) {
                oldQueryItemIndex = i;
                break;
            }
        }
        if (oldQueryItemIndex != NSNotFound) {
            NSURLQueryItem *newQueryItem = [NSURLQueryItem queryItemWithName:key value:value];
            [queryItems replaceObjectAtIndex:oldQueryItemIndex withObject:newQueryItem];
        } else {
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:value]];
        }
    }
    comp.queryItems = queryItems;
    return comp.URL;
}

- (NSDictionary *)queryDictionary {
    NSURLComponents *comp = [NSURLComponents componentsWithURL:self
                                       resolvingAgainstBaseURL:YES];
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    NSArray<NSURLQueryItem *> *queryItems = [comp queryItems];
    for (NSInteger i = 0; i < queryItems.count; i ++) {
        NSURLQueryItem *queryItem = queryItems[i];
        if (queryItem.name) {
            dictionary[queryItem.name] = queryItem.value;
        }
    }
    return dictionary;
}

- (NSURL *)URLByRemovingAllQueryItems {
    NSURLComponents *comp = [NSURLComponents componentsWithURL:self
                                       resolvingAgainstBaseURL:YES];
    comp.queryItems = nil;
    return comp.URL;
}

@end
