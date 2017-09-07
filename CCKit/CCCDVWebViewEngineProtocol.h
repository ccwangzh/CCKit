//
//  CCCDVWebViewEngineProtocol.h
//  CCKit
//
//  Created by can on 17/4/12.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Cordova/CDVWebViewEngineProtocol.h>

@protocol CCCDVWebViewEngineProtocol <CDVWebViewEngineProtocol>
- (void)reload;
- (void)stopLoading;

- (void)goBack;
- (void)goForward;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@end
