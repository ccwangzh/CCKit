//
//  CCTableViewTestCordovaCellModel.m
//  CCKit
//
//  Created by can on 17/3/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCordovaCellModel.h"

#import "CCURLProtocol.h"
#import "CCCDVViewController.h"
#import <Cordova/CDVViewController.h>

@interface CCTestCordovaController : CCCDVViewController
@end

@interface CCTableViewTestCordovaCellModel ()
{
    
}
@end

@implementation CCTableViewTestCordovaCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Cordova";
        [NSURLProtocol registerClass:[CCURLProtocol class]];
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
    testController.startPage = @"http://abs.dtcj.com/test";
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}
@end

@implementation CCTestCordovaController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webViewEngine evaluateJavaScript:@"document.URL" completionHandler:^(id result, NSError *error) {
            NSLog(@"%@", result);
        }];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
