//
//  CCOperation.m
//  CCKit
//
//  Created by can on 17/5/12.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCOperation.h"

@implementation CCOperation

- (BOOL)isCancelled {
    return _cancelled;
}
- (void)setCancelled:(BOOL)isCancelled {
    [self willChangeValueForKey:@"isCancelled"];
    _cancelled = isCancelled;
    [self didChangeValueForKey:@"isCancelled"];
}
- (BOOL)isExecuting {
    return _executing;
}
- (BOOL)isFinished {
    return _finished;
}
- (void)setFinished:(BOOL)isFinished {
    if (isFinished) [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    if (isFinished) _executing = NO;
    _finished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
    if (isFinished) [self didChangeValueForKey:@"isExecuting"];
}
- (void)start {
    if ([self isCancelled]) {
        [self setFinished:YES];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    [self performSelector:@selector(main)];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}
- (void)main {
    NSLog(@"queuePriority:%f", (float)self.queuePriority);
    NSLog(@"time:%f", CFAbsoluteTimeGetCurrent());
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setFinished:YES];
    });
}

@end
