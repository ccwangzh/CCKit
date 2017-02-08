//
//  NSObject+CCModel.h
//  CCKit
//
//  Created by can on 17/2/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CCModel)
+ (instancetype)cc_modelWithJSON:(id)json;
+ (instancetype)cc_modelWithDictionary:(NSDictionary *)dictionary;

- (id)cc_modelToJSONObject;
- (NSData *)cc_modelToJSONData;
- (NSString *)cc_modelToJSONString;

- (void)cc_modelEncodeWithCoder:(NSCoder *)aCoder;
- (id)cc_modelInitWithCoder:(NSCoder *)aDecoder;
@end
