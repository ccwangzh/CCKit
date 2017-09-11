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

#import <WebKit/WebKit.h>

@interface NSURLPattern : NSObject
{
    NSRegularExpression *_urlPattern;
}
- (BOOL)match:(NSURL *)url;
@end

@implementation NSURLPattern
- (instancetype)initWithURLPattern:(NSString *)urlPattern {
    if (self = [super init]) {
        if (urlPattern && urlPattern.length) {
            NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
            _urlPattern = [NSRegularExpression regularExpressionWithPattern:urlPattern options:options error:NULL];
        }
    }
    return self;
}
- (BOOL)match:(NSURL *)url {
    NSString *urlString = [url absoluteString];
    NSRange range = NSMakeRange(0, urlString.length);
    NSMatchingOptions options = NSMatchingReportCompletion;
    NSArray *matches = [_urlPattern matchesInString:urlString options:options range:range];
    return matches.count != 0;
}
@end

@protocol CCWebViewEngineProtocol;
@protocol CCWebViewNavigationDelegate <NSObject>
@optional
- (BOOL)webView:(id<CCWebViewEngineProtocol>)webViewEngine shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
@end
@protocol CCWebViewUIDelegate <NSObject>
@optional
- (void)webViewDidStartLoad:(id<CCWebViewEngineProtocol>)webViewEngine;
- (void)webViewDidFinishLoad:(id<CCWebViewEngineProtocol>)webViewEngine;
- (void)webView:(id<CCWebViewEngineProtocol>)webViewEngine didFailLoadWithError:(NSError *)error;
@end

@protocol CCWebViewEngineProtocol <NSObject>
- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
- (id)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
@property (nonatomic, readonly, strong) NSURLRequest *request;

- (void)reload;
- (void)stopLoading;

- (void)goBack;
- (void)goForward;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

@property (nonatomic, readonly) UIView *webView;

@property (nonatomic, weak) id<CCWebViewUIDelegate> uiDelegate;
@property (nonatomic, weak) id<CCWebViewNavigationDelegate> navigationDelegate;
@end


@interface CCTestWebViewController : CCWebViewController
@property (nonatomic, strong) id<CCWebViewEngineProtocol> webViewEngine;
@end

@interface CCUIWebViewEngine : NSObject
<UIWebViewDelegate, CCWebViewEngineProtocol>
{
    __strong UIWebView *_webView;
    __weak id<CCWebViewUIDelegate> _uiDelegate;
    __weak id<CCWebViewNavigationDelegate> _navigationDelegate;
}
@end

@interface CCWKWebViewEngine : NSObject
<WKUIDelegate, WKNavigationDelegate, CCWebViewEngineProtocol>
{
    __strong WKWebView *_webView;
    __weak id<CCWebViewUIDelegate> _uiDelegate;
    __weak id<CCWebViewNavigationDelegate> _navigationDelegate;
}
@end

@interface CCTableViewTestWebviewCellModel ()
@end

@implementation CCTableViewTestWebviewCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Webview";
        [NSURLProtocol registerClass:[CCURLProtocol class]];
    }
    return self;
}

- (void)doTest1 {
    NSLog(@"doTest");
    NSString *urlPattern = @"^http://[\\w\\.]*\\.baidu\\.com";
    NSURLPattern *pattern = [[NSURLPattern alloc] initWithURLPattern:urlPattern];
    NSURL *url = [NSURL URLWithString:@"http://a.c.m.baidu.com"];
    NSLog(@"match:%d", [pattern match:url]);
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

@implementation CCTestWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    id<CCWebViewEngineProtocol> webViewEngine = nil;
    webViewEngine = [CCWKWebViewEngine new];
     self.webViewEngine = webViewEngine;
    
    UIView *webView = webViewEngine.webView;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
   
    NSURL *url = [NSURL URLWithString:@"https://m.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webViewEngine loadRequest:request];
}
@end

@implementation CCUIWebViewEngine
@synthesize uiDelegate = _uiDelegate;
@synthesize navigationDelegate = _navigationDelegate;
- (instancetype)init {
    if (self = [super init]) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.delegate = self;
    }
    return self;
}
- (id)loadRequest:(NSURLRequest *)request {
    [_webView loadRequest:request];
    return nil;
}
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    [_webView loadHTMLString:string baseURL:baseURL];
    return nil;
}
- (id)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL {
    [_webView loadData:data MIMEType:MIMEType textEncodingName:textEncodingName baseURL:baseURL];
    return nil;
}
- (NSURLRequest *)request {
    return _webView.request;
}
- (void)reload {
    [_webView reload];
}
- (void)stopLoading {
    [_webView stopLoading];
}
- (void)goBack {
    [_webView goBack];
}
- (void)goForward {
    [_webView goForward];
}
- (BOOL)canGoBack {
    return [_webView canGoBack];
}
- (BOOL)canGoForward {
    return [_webView canGoForward];
}
- (BOOL)isLoading {
    return [_webView isLoading];
}
- (UIView *)webView {
    return _webView;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [uiDelegate webViewDidStartLoad:self];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [uiDelegate webViewDidFinishLoad:self];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [uiDelegate webView:self didFailLoadWithError:error];
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    id<CCWebViewNavigationDelegate> navigationDelegate = self.navigationDelegate;
    if (navigationDelegate && [navigationDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [navigationDelegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}
@end

@implementation CCWKWebViewEngine
@synthesize uiDelegate = _uiDelegate;
@synthesize navigationDelegate = _navigationDelegate;
static WKProcessPool *processPool = nil;
- (instancetype)init {
    if (self = [super init]) {
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        if (!processPool) processPool = [WKProcessPool new];
        configuration.processPool = processPool;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return self;
}
- (id)loadRequest:(NSURLRequest *)request {
    return [_webView loadRequest:request];
}
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    return [_webView loadHTMLString:string baseURL:baseURL];
}
- (id)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL {
    return [_webView loadData:data MIMEType:MIMEType characterEncodingName:textEncodingName baseURL:baseURL];
}
- (NSURLRequest *)request {
    return nil;
}
- (void)reload {
    [_webView reload];
}
- (void)stopLoading {
    [_webView stopLoading];
}
- (void)goBack {
    [_webView goBack];
}
- (void)goForward {
    [_webView goForward];
}
- (BOOL)canGoBack {
    return [_webView canGoBack];
}
- (BOOL)canGoForward {
    return [_webView canGoForward];
}
- (BOOL)isLoading {
    return [_webView isLoading];
}
- (UIView *)webView {
    return _webView;
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [uiDelegate webViewDidStartLoad:self];
    }
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [uiDelegate webView:self didFailLoadWithError:error];
    }
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [uiDelegate webView:self didFailLoadWithError:error];
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    id<CCWebViewUIDelegate> uiDelegate = self.uiDelegate;
    if (uiDelegate && [uiDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [uiDelegate webViewDidFinishLoad:self];
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    id<CCWebViewNavigationDelegate> navigationDelegate = self.navigationDelegate;
    if (navigationDelegate && [navigationDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        NSInteger navigationType = navigationAction.navigationType;
        switch (navigationType) { case WKNavigationTypeOther: navigationType = UIWebViewNavigationTypeOther; break;}
        if (![navigationDelegate webView:self shouldStartLoadWithRequest:navigationAction.request navigationType:navigationType]) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
@end
