//
//  CCUIWebViewEngine.m
//  CCKit
//
//  Created by can on 17/4/12.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCUIWebViewEngine.h"

@protocol CCUIWebViewFrameInfo <NSObject>
- (BOOL)isMainFrame;
@end

@protocol CCUIWebViewExtension <NSObject>
- (void)webView:(id)webview didReceiveTitle:(NSString *)title forFrame:(id<CCUIWebViewFrameInfo>)frame;
@end

@interface UIWebView (VFUIWebViewPrivate)
- (void)webView:(id)webview didReceiveTitle:(NSString *)title forFrame:(id<CCUIWebViewFrameInfo>)frame;
- (void)webView:(id)view didStartProvisionalLoadForFrame:(id<CCUIWebViewFrameInfo>)frame;
- (void)webView:(id)view didFinishLoadForFrame:(id<CCUIWebViewFrameInfo>)frame;
- (void)webView:(id)view didChangeLocationWithinPageForFrame:(id<CCUIWebViewFrameInfo>)frame;
@end

@interface CCUIWebView : UIWebView
@property (nonatomic, weak) id<CCUIWebViewExtension> extDelegate;
@end

@implementation CCUIWebView
- (void)webView:(id)webview didReceiveTitle:(NSString *)title forFrame:(id<CCUIWebViewFrameInfo>)frame {
    if ([_extDelegate respondsToSelector:@selector(webView:didReceiveTitle:forFrame:)]) {
        [_extDelegate webView:self didReceiveTitle:title forFrame:frame];
    }
    [super webView:webview didReceiveTitle:title forFrame:frame];
}

@end

@interface CCUIWebViewEngine () <CCUIWebViewExtension>

@end

@implementation CCUIWebViewEngine
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        CCUIWebView *engineWebView = [[CCUIWebView alloc] initWithFrame:frame];
        [self setValue:engineWebView forKey:@"engineWebView"];
        [engineWebView setExtDelegate:self];
    }
    return self;
}

- (void)reload {
    [(UIWebView *)self.webView reload];
}

- (void)stopLoading {
    [(UIWebView *)self.webView stopLoading];
}

- (void)goBack {
    [(UIWebView *)self.webView goBack];
}

- (void)goForward {
    [(UIWebView *)self.webView goBack];
}

- (BOOL)canGoBack {
    return [(UIWebView *)self.webView canGoBack];
}

- (BOOL)canGoForward {
    return [(UIWebView *)self.webView canGoForward];
}

- (BOOL)isLoading {
    return [(UIWebView *)self.webView isLoading];
}

- (void)webView:(id)webview didReceiveTitle:(NSString *)title forFrame:(id<CCUIWebViewFrameInfo>)frame {
    
}
@end
