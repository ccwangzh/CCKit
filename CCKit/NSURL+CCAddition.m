//
//  NSURL+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/6.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "NSURL+CCAddition.h"

@implementation NSURL (CCAddition)
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString
{
    if (!queryString || queryString.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"%@://%@", self.scheme, self.host];
    if (self.port) {
        [string appendFormat:@":%@", self.port];
    }
    if (self.path) {
        [string appendFormat:@"%@", self.path];
    }
    if (self.parameterString) {
        [string appendFormat:@";%@", self.parameterString];
    }
    [string appendString:@"?"];
    if (self.query) {
        [string appendFormat:@"%@&", self.query];
    }
    [string appendFormat:@"%@", queryString];
    if (self.fragment) {
        [string appendFormat:@"#%@", self.fragment];
    }
    return [NSURL URLWithString:string] ? : self;
}
- (NSURL *)URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary {
    NSMutableString *paraString = [NSMutableString new];
    [queryDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [paraString appendFormat:@"%@=%@&", key, obj];
    }];
    if (paraString.length && [paraString hasSuffix:@"&"]) {
        [paraString deleteCharactersInRange:NSMakeRange(paraString.length - 1, 1)];
    }
    return [self URLByAppendingQueryString:paraString];
}
- (NSURL *)URLByReplacingQueryDictionary:(NSDictionary *)queryDictionary {
    if (!queryDictionary || queryDictionary.count == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"%@://%@", self.scheme, self.host];
    if (self.port) {
        [string appendFormat:@":%@", self.port];
    }
    if (self.path) {
        [string appendFormat:@"%@", self.path];
    }
    if (self.parameterString) {
        [string appendFormat:@";%@", self.parameterString];
    }
    NSDictionary *queryDict = [self queryDictionary];
    NSMutableDictionary *mutable = [queryDict mutableCopy];
    [mutable addEntriesFromDictionary:queryDictionary];
    NSMutableString *queryString = [NSMutableString new];
    [mutable enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [queryString appendFormat:@"%@=%@&", key, obj];
    }];
    if (queryString.length) {
        if ([queryString hasSuffix:@"&"]) {
            [queryString deleteCharactersInRange:NSMakeRange(queryString.length - 1, 1)];
        }
        [string appendFormat:@"?%@", queryString];
    }
    if (self.fragment) {
        [string appendFormat:@"#%@", self.fragment];
    }
    return [NSURL URLWithString:string] ? : self;
}

- (NSDictionary *)queryDictionary {
    NSString *query = self.query;
    if (!query || query.length == 0) {
        return nil;
    }
    
    NSArray *componments = [query componentsSeparatedByString:@"&"];
    if (componments.count == 0) return nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSString *componment in componments) {
        NSArray *paras = [componment componentsSeparatedByString:@"="];
        NSInteger count = [paras count];
        NSString *key = count > 0 ? paras[0] : nil;
        NSString *value = count > 1 ? paras[1] : @"";
        
        if (key == nil || value == nil) continue;
        
       [dict setObject:value forKey:key];
    }
    return dict;
}
- (BOOL)hasQueryDictionary:(NSDictionary *)queryDictionary {
    NSSet *set1 = [NSSet setWithArray:[[self queryDictionary] allKeys]];
    NSSet *set2 = [NSSet setWithArray:[queryDictionary allKeys]];
    return [set2 isSubsetOfSet:set1];
}
- (BOOL)hasQueryName:(NSString *)queryName {
    return [self.query rangeOfString:queryName].location != NSNotFound;
}

@end
