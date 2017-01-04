//
//  NSObject+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "NSObject+CCAddition.h"

#include <objc/runtime.h>

@implementation NSObject (CCAddition)
- (void)setAssociatedObject:(id)object key:(const void *)key
{
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getAssociatedObjectForKey:(const void *)key
{
    return objc_getAssociatedObject(self, key);
}
@end
