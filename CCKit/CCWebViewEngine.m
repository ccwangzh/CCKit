//
//  CCWebViewEngine.m
//  CCKit
//
//  Created by can on 17/3/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCWebViewEngine.h"

#import <WebKit/WebKit.h>

@interface CCWebViewEngine ()
<UIWebViewDelegate, WKNavigationDelegate>
{
    __strong UIView *_webView;
    __strong UIWebView *_uiWebView;
    __strong WKWebView *_wkWebView;
}
@end

@implementation CCWebViewEngine
@synthesize webView = _webView;
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0) {
            _uiWebView = [[UIWebView alloc] initWithFrame:frame];
            _uiWebView.delegate = self;
            _webView = _uiWebView;
        } else {
            WKWebViewConfiguration *webConfig = [WKWebViewConfiguration new];
            _wkWebView = [[WKWebView alloc] initWithFrame:frame configuration:webConfig];
            _wkWebView.navigationDelegate = self;
            _webView = _wkWebView;
        }
    }
    return self;
}

- (id)loadRequest:(NSURLRequest *)request {
    if (_wkWebView) {
        return [_wkWebView loadRequest:request];
    } else {
        [_uiWebView loadRequest:request];
        return nil;
    }
}

- (id)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL {
    if (_wkWebView) {
        return [_wkWebView loadHTMLString:string baseURL:baseURL];
    } else {
        [_uiWebView loadHTMLString:string baseURL:baseURL];
        return nil;
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"webView:%@,decidePolicyForNavigationAction:%@", webView, navigationAction);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"webView:%@,decidePolicyForNavigationResponse:%@", webView, navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"webView:%@,didStartProvisionalNavigation:%@", webView, navigation);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"webView:%@,didReceiveServerRedirectForProvisionalNavigation:%@", webView, navigation);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"webView:%@,didFailProvisionalNavigation:%@,error:%@", webView, navigation, error);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"webView:%@,didCommitNavigation:%@", webView, navigation);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"webView:%@,didFinishNavigation:%@", webView, navigation);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"webView:%@,didFailNavigation:%@,error:%@", webView, navigation, error);
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest:%@,%@", webView, request);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad:%@", webView);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad:%@", webView);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"webView:didFailLoadWithError:%@", webView);
}

@end
