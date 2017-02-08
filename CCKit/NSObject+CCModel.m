//
//  NSObject+CCModel.m
//  CCKit
//
//  Created by can on 17/2/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "NSObject+CCModel.h"

#define VFAutoMappingYYModel    1
#ifdef VFAutoMappingYYModel
    #import <YYModel/YYModel.h>
#endif

@implementation NSObject (CCModel)
+ (instancetype)cc_modelWithJSON:(id)json
{
#ifdef VFAutoMappingYYModel
    return [self yy_modelWithJSON:json];
#else
    return nil;
#endif
}
+ (instancetype)cc_modelWithDictionary:(NSDictionary *)dictionary
{
#ifdef VFAutoMappingYYModel
    return [self yy_modelWithDictionary:dictionary];
#else
    return nil;
#endif
}

- (id)cc_modelToJSONObject
{
#ifdef VFAutoMappingYYModel
    return [self yy_modelToJSONObject];
#else
    return nil;
#endif
}
- (NSData *)cc_modelToJSONData
{
#ifdef VFAutoMappingYYModel
    return [self yy_modelToJSONData];
#else
    return nil;
#endif
}
- (NSString *)cc_modelToJSONString
{
#ifdef VFAutoMappingYYModel
    return [self yy_modelToJSONString];
#else
    return nil;
#endif
}

- (void)cc_modelEncodeWithCoder:(NSCoder *)aCoder
{
#ifdef VFAutoMappingYYModel
    [self yy_modelEncodeWithCoder:aCoder];
#endif
}
- (id)cc_modelInitWithCoder:(NSCoder *)aDecoder
{
#ifdef VFAutoMappingYYModel
    return [self yy_modelInitWithCoder:aDecoder];
#else
    return self;
#endif
}
@end
