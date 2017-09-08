//
//  CCTableViewTestCollectionsCellModel.m
//  CCKit
//
//  Created by can on 5/13/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import "CCTableViewTestCollectionsCellModel.h"

@implementation CCTableViewTestCollectionsCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Collections";
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
    
    // 1
    [self testHashTable];
 
    // 2
    [self testSet];
    
    // 3
    [self testOrderedSet];
    
}

- (void)testHashTable {
    NSHashTable *table = [NSHashTable new];
    [table addObject:@"a"];
}

- (void)testSet {
    NSMutableSet *set = [NSMutableSet new];
    [set addObject:@1];
    [set addObject:@3];
    [set addObject:@2];
    
    [set addObject:@3];
    
    [set addObject:@1];

    NSLog(@"NSMutableSet:%@", [set debugDescription]);
}

- (void)testOrderedSet {
    NSMutableOrderedSet *orderedSet = [NSMutableOrderedSet new];
    [orderedSet addObject:@1];
    [orderedSet addObject:@3];
    [orderedSet addObject:@2];
    
    [orderedSet addObject:@3];
    
    [orderedSet addObject:@1];
    
    NSLog(@"NSMutableOrderedSet:%@", [orderedSet debugDescription]);
}

@end
