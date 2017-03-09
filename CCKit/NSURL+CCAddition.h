//
//  NSURL+CCAddition.h
//  CCKit
//
//  Created by can on 17/1/6.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (CCAddition)
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
- (NSURL *)URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary;
- (NSURL *)URLByReplacingQueryDictionary:(NSDictionary *)queryDictionary;
@property (nonatomic, readonly) NSDictionary *queryDictionary;
- (BOOL)hasQueryDictionary:(NSDictionary *)queryDictionary;
- (BOOL)hasQueryName:(NSString *)queryName;
@end
