//
//  NSObject+CCAddition.m
//  CCAdditions
//
//  Created by ccwangzh on 2017/12/11.
//

#import "NSObject+CCAddition.h"
#include <objc/runtime.h>

@implementation NSObject (CCAddition)
- (id)getAssociatedObjectForKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}
- (void)setAssociatedObject:(id)object key:(const void *)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
