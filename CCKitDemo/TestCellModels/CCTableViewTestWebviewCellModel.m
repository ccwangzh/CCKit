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

static WKWebView *cookieStorage = nil;
static WKProcessPool *processPool = nil;

@interface CCTestWebViewController : CCWebViewController
<UIWebViewDelegate,
WKUIDelegate, WKNavigationDelegate>
@property (nonatomic) UIWebView *uiWebView;
@property (nonatomic) WKWebView *wkWebView;
@end

@implementation CCTestWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
#if 0
    self.uiWebView = [[UIWebView alloc] init];
    self.uiWebView.backgroundColor = [UIColor redColor];
    self.uiWebView.frame = self.view.bounds;
    self.uiWebView.delegate = self;
    [self.view addSubview:self.uiWebView];
    
    NSURL *url = [NSURL URLWithString:@"https://m.baidu.com/"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:5.0f];
    [self.uiWebView loadRequest:mutableRequest];
#else

    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    configuration.processPool = processPool;
    WKUserContentController *userContentController = [WKUserContentController new];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"alert('aaaa');"
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                   forMainFrameOnly:NO];
    //[userContentController addUserScript:userScript];
    configuration.userContentController = userContentController;
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;

    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.wkWebView.backgroundColor = [UIColor redColor];
    self.wkWebView.frame = self.view.bounds;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:5.0f];
    [self.wkWebView loadRequest:mutableRequest];
    
    NSString *html = @"<!DOCTYPE html>\
<body>\
</body>\
<script>\
alert(document.cookie);\
</script>\
<html>";
    url = [NSURL URLWithString:@"https://localhost/init"];
    //[self.wkWebView loadHTMLString:html baseURL:url];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.wkWebView evaluateJavaScript:@"alert('a');" completionHandler:NULL];
//    });
    
#endif
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

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView*)webView runJavaScriptAlertPanelWithMessage:(NSString*)message initiatedByFrame:(WKFrameInfo*)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:self.title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        completionHandler();
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    UIViewController* rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootController presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView*)webView runJavaScriptConfirmPanelWithMessage:(NSString*)message initiatedByFrame:(WKFrameInfo*)frame completionHandler:(void (^)(BOOL result))completionHandler {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:self.title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        completionHandler(YES);
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        completionHandler(NO);
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    UIViewController* rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootController presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView*)webView runJavaScriptTextInputPanelWithPrompt:(NSString*)prompt defaultText:(NSString*)defaultText initiatedByFrame:(WKFrameInfo*)frame completionHandler:(void (^)(NSString* result))completionHandler {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:self.title message:prompt preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        completionHandler(((UITextField*)alert.textFields[0]).text);
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        completionHandler(nil);
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [alert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.text = defaultText;
    }];
    
    UIViewController* rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootController presentViewController:alert animated:YES completion:nil];
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
        
        if (!processPool) {
            processPool = [WKProcessPool new];
        }
        NSString *cookieScript = @"document.cookie='test=aaa;domain=localhost;'";
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.processPool = processPool;
        WKUserContentController *userContentController = [WKUserContentController new];
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:cookieScript
                                                          injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                       forMainFrameOnly:NO];
        [userContentController addUserScript:userScript];
        configuration.userContentController = userContentController;
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptEnabled = YES;
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;

        if (!cookieStorage) {
            cookieStorage = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        }
        
        NSString *html = @"<!DOCTYPE html><body></body><html>";
        NSURL *url = [NSURL URLWithString:@"https://localhost/cookie"];
        [cookieStorage loadHTMLString:html baseURL:url];

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
