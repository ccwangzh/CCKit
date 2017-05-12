//
//  CCTableViewTestWebviewCellModel.m
//  CCKit
//
//  Created by can on 17/3/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestWebviewCellModel.h"

#import "CCURLProtocol.h"
#import "CCWebViewEngine.h"
#import "CCWebViewController.h"

@interface CCTestWebViewController : CCWebViewController
@property (nonatomic) CCWebViewEngine *webEngine;
@end

@implementation CCTestWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webEngine = [[CCWebViewEngine alloc] init];
    UIView *webview = self.webEngine.webView;
    webview.frame = self.view.bounds;
    [self.view addSubview:webview];
    
    webview.backgroundColor = [UIColor redColor];
    NSURL *url = [NSURL URLWithString:@"http://www.useragentstring.com/"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:5.0f];
    [self.webEngine loadRequest:mutableRequest];
}
@end

@interface CCTableViewTestWebviewCellModel ()
{
    
}
@end

@implementation CCTableViewTestWebviewCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Webview";
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
    
    CCTestWebViewController *testController = [CCTestWebViewController new];
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
    
}
@end
