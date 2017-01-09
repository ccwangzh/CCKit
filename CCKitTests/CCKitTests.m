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

#import "NSURL+CCAddition.h"
#import "NSString+CCAddition.h"
#import "NSObject+CCAddition.h"


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

- (void)testNSString_CCAddition {
    XCTAssertTrue([[@"123" md5Value] isEqualToString:@"202cb962ac59075b964b07152d234b70"]);
    
    XCTAssertTrue([[@"123" sha1Value] isEqualToString:@"40bd001563085fc35165329ea1ff5c5ecbdbbeef"]);

    XCTAssertTrue([@"ddd@sina.com" isEmail]);
    
    XCTAssertFalse([@"ddd@sina" isEmail]);
 
    XCTAssertTrue([@"18012345678" isPhone]);
    
    XCTAssertFalse([@"188123456" isPhone]);

    XCTAssertTrue([@"18012345678" isDigit]);
    
    XCTAssertFalse([@"188O123456" isDigit]);
    
}

- (void)testNSURL_CCAddition {
    NSURL *url = [NSURL URLWithString:@"https://ddd.bbb.com:8080/rrr;aaa?opop=ggy&nn=77&ff=dd#djajd_dhja"];
    NSURL *urlNew = [url URLByAppendingQueryString:@"aa=cc&bb=cc"];
    NSString *string = @"https://ddd.bbb.com:8080/rrr;aaa?opop=ggy&nn=77&ff=dd&aa=cc&bb=cc#djajd_dhja";
    
    XCTAssertTrue([string isEqualToString:urlNew.absoluteString]);
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
    
    NSString *object = @"object";
    const void *kk = &kk;
    
    CCLog(@"%p,%p", kk, &kk);
    
    [self setAssociatedObject:object key:kk];
    
    NSString *objectNew = [self getAssociatedObjectForKey:kk];
    
    NSLog(@"object:%@", objectNew);
}

















@end
