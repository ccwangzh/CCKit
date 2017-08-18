//
//  CCTableViewTestOperationCellModel.m
//  CCKit
//
//  Created by can on 5/8/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import "CCTableViewTestOperationCellModel.h"

@protocol CCPrioritizable <NSObject>
@property (nonatomic, assign) NSInteger priority;
@end

@interface CCPriorityQueue : NSObject
{
    NSLock *_lock;
    NSMutableArray *_queue;
}
- (void)addObject:(id<CCPrioritizable>)object;
- (void)removeObject:(id<CCPrioritizable>)object;
- (id<CCPrioritizable>)popObject;
@end

@interface CCPriorityObject : NSObject <CCPrioritizable>
@property (nonatomic, assign) NSInteger priority;
@end

@implementation CCPriorityObject
- (NSString *)description {
    return [NSString stringWithFormat:@"CCPriorityObject:%p,%ld", self, (long)_priority];
}
@end

@implementation CCPriorityQueue
- (instancetype)init {
    if (self = [super init]) {
        _lock = [NSLock new];
        _queue = [NSMutableArray new];
    }
    return self;
}
- (void)addObject:(id<CCPrioritizable>)object {
    [_lock lock];
    
    NSInteger count = _queue.count;
    BOOL hasInertInToQueue = NO;
    for (NSInteger i = 0; i < count; i ++) {
        id<CCPrioritizable> otherObject = _queue[i];
        if ([object priority] > [otherObject priority]) {
            hasInertInToQueue = YES;
            [_queue insertObject:object atIndex:i];
            break;
        }
    }
    if (!hasInertInToQueue) {
        [_queue addObject:object];
    }
    
    [_lock unlock];
}
- (void)removeObject:(id<CCPrioritizable>)object {
    [_lock lock];
    [_queue removeObject:object];
    [_lock unlock];
}

- (id<CCPrioritizable>)popObject {
    [_lock lock];
    id<CCPrioritizable> firstObject = [_queue firstObject];
    if (firstObject) {
        [_queue removeObjectAtIndex:0];
    }
    [_lock unlock];
    return firstObject;
}

- (NSString *)description {
    return [_queue description];
}

@end

@interface CCTableViewTestOperationCellModel ()
{
    CCPriorityQueue *_queue;
}
@end

@implementation CCTableViewTestOperationCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Operation";
        _queue = [CCPriorityQueue new];
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
    
    CCPriorityObject *p1 = [CCPriorityObject new];
    p1.priority = 1;
    [_queue addObject:p1];
    NSLog(@"%@", _queue);
    
    CCPriorityObject *p5 = [CCPriorityObject new];
    p5.priority = 5;
    [_queue addObject:p5];
    NSLog(@"%@", _queue);
    
    CCPriorityObject *p3 = [CCPriorityObject new];
    p3.priority = 3;
    [_queue addObject:p3];
    NSLog(@"%@", _queue);
    
    CCPriorityObject *p4 = [CCPriorityObject new];
    p4.priority = 4;
    [_queue addObject:p4];
    NSLog(@"%@", _queue);
    
    CCPriorityObject *p2 = [CCPriorityObject new];
    p2.priority = 2;
    [_queue addObject:p2];
    NSLog(@"%@", _queue);

    CCPriorityObject *p22 = [CCPriorityObject new];
    p22.priority = 2;
    [_queue addObject:p22];
    [_queue addObject:p22];
    NSLog(@"%@", _queue);
    
    [_queue popObject];
    NSLog(@"%@", _queue);
}

@end
