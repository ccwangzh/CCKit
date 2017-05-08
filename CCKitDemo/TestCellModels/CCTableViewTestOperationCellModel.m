//
//  CCTableViewTestOperationCellModel.m
//  CCKit
//
//  Created by can on 5/8/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import "CCTableViewTestOperationCellModel.h"

@interface CCPriorityQueue : NSObject

@end

@implementation CCPriorityQueue

@end

@interface CCTableViewTestOperationCellModel ()
{
    NSOperationQueue *_queue;
}
@end

@implementation CCTableViewTestOperationCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Operation";
        _queue = [NSOperationQueue new];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
}

@end
