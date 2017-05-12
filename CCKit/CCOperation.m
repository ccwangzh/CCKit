//
//  CCOperation.m
//  CCKit
//
//  Created by can on 17/5/12.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCOperation.h"

@interface CCOperation ()
@property (nonatomic) NSTimer *t;
@property (nonatomic) NSLock *lock;
@end

@implementation CCOperation

- (NSLock *)lock {
    if (_lock) {
        return _lock;
    }
    _lock = [NSLock new];
    return _lock;
}

- (BOOL)isCancelled {
    return _cancelled;
}

- (void)setCancelled:(BOOL)isCancelled {
    [self.lock lock];
    [self willChangeValueForKey:@"isCancelled"];
    _cancelled = isCancelled;
    [self didChangeValueForKey:@"isCancelled"];
    [self.lock unlock];
}

- (BOOL)isExecuting {
    return _executing;
}

- (void)setExecuting:(BOOL)isExecuting {
    [self.lock lock];
    [self willChangeValueForKey:@"isExecuting"];
    _executing = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
    [self.lock unlock];
}

- (BOOL)isFinished {
    return _finished;
}

- (void)setFinished:(BOOL)isFinished {
    [self.lock lock];
    [self willChangeValueForKey:@"isFinished"];
    _finished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
    [self.lock unlock];
}

- (void)cancel {
    if (![self isExecuting]) {
        [self setCancelled:YES];
    }
}
- (void)main {
    if ([self isCancelled]) {
        [self setFinished:YES];
        return;
    }
    [self setExecuting:YES];
    NSLog(@"queuePriority:%f", (float)self.queuePriority);
    NSLog(@"time:%f", CFAbsoluteTimeGetCurrent());
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setFinished:YES];
    });
}

- (void)dealloc {
    NSLog(@"dealloc:%@", self);
}

@end
