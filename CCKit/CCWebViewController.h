//
//  CCWebViewController.h
//  CCKit
//
//  Created by can on 17/1/19.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCViewController.h"

@interface CCWebViewController : CCViewController

@end

@interface CCWebViewEngine : NSObject
@property (nonatomic, strong, readonly) UIView *webView;

- (instancetype)initWithFrame:(CGRect)frame;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
@end
