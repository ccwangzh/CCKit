//
//  CCWebViewEngine.h
//  CCKit
//
//  Created by can on 17/3/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

@interface CCWebViewEngine : CDVPlugin
@property (nonatomic, strong, readonly) UIView *webView;

- (instancetype)initWithFrame:(CGRect)frame;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
@end

