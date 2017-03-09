//
//  CCWebViewController.m
//  CCKit
//
//  Created by can on 17/1/19.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCWebViewController.h"

#import <WebKit/WebKit.h>

@interface CCWebViewController ()

@end

@interface CCWebViewEngine ()
<UIWebViewDelegate>
{
    __strong UIView *_webView;
    __strong UIWebView *_uiWebView;
    __strong WKWebView *_wkWebView;
}
@end

@implementation CCWebViewController

@end

@implementation CCWebViewEngine
@synthesize webView = _webView;
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            _uiWebView = [[UIWebView alloc] initWithFrame:frame];
            _uiWebView.delegate = self;
            _webView = _uiWebView;
        } else {
            WKWebViewConfiguration *webConfig = [WKWebViewConfiguration new];
            _wkWebView = [[WKWebView alloc] initWithFrame:frame configuration:webConfig];
            _webView = _wkWebView;
        }
    }
    return self;
}

- (id)loadRequest:(NSURLRequest *)request {
    if (_wkWebView) {
       return [_wkWebView loadRequest:request];
    } else if (_uiWebView) {
        [_uiWebView loadRequest:request];
        return nil;
    }
    return nil;
}

- (id)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL {
    if (_wkWebView) {
        return [_wkWebView loadHTMLString:string baseURL:baseURL];
    } else if (_uiWebView) {
        [_uiWebView loadHTMLString:string baseURL:baseURL];
        return nil;
    }
    return nil;
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
