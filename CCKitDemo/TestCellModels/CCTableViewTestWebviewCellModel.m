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

#import <JavaScriptCore/JavaScriptCore.h>

@protocol OTOSaaSJavaScriptDelegate <JSExport>
- (void)setBackUrl:(NSString *)url;
@end

@interface OTOSaaSJavaScriptModel : NSObject
<OTOSaaSJavaScriptDelegate>
@end

@implementation OTOSaaSJavaScriptModel
- (void)setBackUrl:(NSString *)url {
    
}
@end

@interface CCTestWebViewController : CCWebViewController
<UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@end

@implementation CCTestWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.view.bounds;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.webView.backgroundColor = [UIColor redColor];
    
    
    NSURL *url = [NSURL URLWithString:@"https://m.baidu.com/"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:5.0f];
    [self.webView loadRequest:mutableRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *path = @"documentView.webView.mainFrame.javaScriptContext";
    JSContext *jsContext = [webView valueForKeyPath:path];
    OTOSaaSJavaScriptModel *model = [OTOSaaSJavaScriptModel new];
    [jsContext setObject:model forKeyedSubscript:@"otosaas"];
    [jsContext setExceptionHandler:^(JSContext *jsContext, JSValue *jsValue) {
        NSLog(@"exception:%@", jsValue);
    }];
    
    NSLog(@"%@", jsContext);
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
