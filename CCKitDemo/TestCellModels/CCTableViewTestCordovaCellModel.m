//
//  CCTableViewTestCordovaCellModel.m
//  CCKit
//
//  Created by can on 17/3/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCordovaCellModel.h"

#import <Cordova/CDVViewController.h>

@interface CCTestCordovaController : CDVViewController

@end

@implementation CCTestCordovaController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end

@interface CCTableViewTestCordovaCellModel ()
{
    
}
@end

@implementation CCTableViewTestCordovaCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Cordova";
    }
    return self;
}
- (void)doTest {
    NSLog(@"doTest");
    UIApplication *application = [UIApplication sharedApplication];
    UIViewController *rootController = [application keyWindow].rootViewController;
    UITabBarController *tabController = (UITabBarController *)rootController;
    UINavigationController *navController = [tabController selectedViewController];
    
    CCTestCordovaController *testController = [CCTestCordovaController new];
    testController.configFile = @"CCTableViewTestCordovaCellModel.xml";
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}
@end
