//
//  CCKitTests.m
//  CCKitTests
//
//  Created by can on 17/1/3.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCDefines.h"

#import "UIColor+CCAddition.h"
#import "UIImage+CCAddition.h"
#import "UIScreen+CCAddition.h"

@interface CCKitTests : XCTestCase

@end

@implementation CCKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testDefines {
    CCLog(@"aaaaa");
    
    CCLogDebug(@"DEBUG:%@", @"testDefines");
    
    CCLogError(@"ERROR:%@", @"testDefines");
}

- (void)testAdditions {
    UIColor *c = [UIColor colorWithRGB:0xaabbcc];
    CCLog(@"color:%@", c);
    c = [UIColor colorWithRGBA:0xaabbccdd];
    CCLog(@"color:%@", c);
    
    c = [UIColor colorWithR:111 g:112 b:113];
    CCLog(@"color:%@", c);
    c = [UIColor colorWithR:111 g:112 b:113 alpha:233];
    CCLog(@"color:%@", c);
    
    UIImage *i = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(2, 2)];
    CCLog(@"image:%@", i);
    i = [UIImage imageWithColor:[UIColor whiteColor]];
    CCLog(@"image:%@", i);
    
    CGFloat width = [UIScreen mainScreenWidth];
    CCLog(@"mainScreenWidth:%f", width);
    CGFloat height = [UIScreen mainScreenHeight];
    CCLog(@"mainScreenHeight:%f", height);
    CGSize size = [UIScreen mainScreenSize];
    CCLog(@"mainScreenSize:%@", NSStringFromCGSize(size));
}

@end
