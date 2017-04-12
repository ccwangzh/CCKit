//
//  CCCDVViewController.m
//  CCKit
//
//  Created by can on 17/3/13.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCCDVViewController.h"
#import <Cordova/CDVUIWebViewNavigationDelegate.h>

@interface CCCDVViewController ()

@end

@implementation CCCDVViewController
@synthesize webViewEngine;

- (id<UIWebViewDelegate>)navigationDelegate {
    if (_navigationDelegate) {
        return _navigationDelegate;
    }
    _navigationDelegate = [[CDVUIWebViewNavigationDelegate alloc] initWithEnginePlugin:self.webViewEngine];
    return _navigationDelegate;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return [[self navigationDelegate] webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[self navigationDelegate] webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[self navigationDelegate] webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[self navigationDelegate] webView:webView didFailLoadWithError:error];
}

@end
