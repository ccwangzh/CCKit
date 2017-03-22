//
//  CCTableViewTestCordovaCellModel.m
//  CCKit
//
//  Created by can on 17/3/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCordovaCellModel.h"

#import "CCURLProtocol.h"
#import <Cordova/CDVViewController.h>

@interface CCTestCordovaController : CDVViewController
@end

@protocol CCCordovaLoginDelegate <NSObject>
- (void)cordovaWillLoginWithURL:(NSURL *)url;
@end

@interface CCCordovaLoginHandler: CDVPlugin
@property (nonatomic, weak) UIViewController<CCCordovaLoginDelegate>* viewController;
@end

@protocol CCCordovaShareDelegate <NSObject>
- (void)cordovaWillShareWithURL:(NSURL *)url;
@end

@interface CCCordovaShareHandler : CDVPlugin
@property (nonatomic, weak) UIViewController<CCCordovaShareDelegate>* viewController;
@end

@interface CCCordovaRequestHandler : CDVPlugin
@property (nonatomic) NSURLRequest *previousRequest;
@end

@interface CCTableViewTestCordovaCellModel ()
{
    
}
@end

@implementation CCTableViewTestCordovaCellModel
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
//    testController.startPage = @"http://cdn.bootcss.com/angular.js/2.0.0-beta.17/angular2.js";
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}
@end

@implementation CCCordovaLoginHandler
@dynamic viewController;
- (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL]; NSString *scheme = [url scheme]; NSString *host = [url host];
    if (([scheme hasPrefix:@"vip"] && [host isEqualToString:@"login"])
        || ([scheme hasPrefix:@"http"] && [host isEqualToString:@"m.login.vip.com"])) {
        UIViewController *viewController = self.viewController;
        if ([viewController respondsToSelector:@selector(cordovaWillLoginWithURL:)]) {
            [(id<CCCordovaLoginDelegate>)viewController cordovaWillLoginWithURL:url];
            return NO;
        }
    }
    return YES;
}
@end

@implementation CCCordovaShareHandler
@dynamic viewController;
- (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL]; NSString *scheme = [url scheme]; NSString *host = [url host];
    if ([scheme hasPrefix:@"vip"] && [host hasPrefix:@"share"]) {
        UIViewController *viewController = self.viewController;
        if ([viewController respondsToSelector:@selector(cordovaWillShareWithURL:)]) {
            [(id<CCCordovaShareDelegate>)viewController cordovaWillShareWithURL:url];
            return NO;
        }
    }
    return YES;
}
@end

@implementation CCCordovaRequestHandler
- (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
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
