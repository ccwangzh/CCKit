//
//  UIControl+CCAddition.m
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "UIControl+CCAddition.h"

#include <objc/runtime.h>

@interface CCControlEventHandler : NSObject
{
    UIControlEvents _events;
    void (^_action)(UIControl *control,UIEvent *event);
}
+ (instancetype)handlerWithEvents:(UIControlEvents)events
                           action:(void (^)(UIControl *control, UIEvent *event))action;
@end

@implementation CCControlEventHandler
+ (instancetype)handlerWithEvents:(UIControlEvents)events
                           action:(void (^)(UIControl *control, UIEvent *event))action {
    return [[self alloc] initWithEvents:events action:action];
}

- (instancetype)initWithEvents:(UIControlEvents)events
                        action:(void (^)(UIControl *control, UIEvent *event))action {
    if (self = [super init]) {
        _events = events; _action = action;
    }
    return self;
}

- (void)doAction:(UIControl *)control withEvent:(UIEvent *)event {
    if (_action) _action(control, event);
}

@end

const void *kUIControlHandlersAssociatedKey = &kUIControlHandlersAssociatedKey;

@implementation UIControl (CCAddition)
- (NSMutableArray *)cc_handlers {
    NSMutableArray *handlers = objc_getAssociatedObject(self, kUIControlHandlersAssociatedKey);
    if (handlers == nil) {
        handlers = [NSMutableArray new];
        objc_setAssociatedObject(self, kUIControlHandlersAssociatedKey, handlers, OBJC_ASSOCIATION_RETAIN);
    }
    return handlers;
}

- (void)setAction:(void (^)(UIControl *control, UIEvent *event))action forEvents:(UIControlEvents)events {
    if (action == nil || events == 0) return;
    
    CCControlEventHandler *handler = [CCControlEventHandler handlerWithEvents:events action:action];
    [[self cc_handlers] addObject:handler];
    [self addTarget:handler action:@selector(doAction:withEvent:) forControlEvents:events];
}
@end
