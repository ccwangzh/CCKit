//
//  CCCDVViewController.h
//  CCKit
//
//  Created by can on 17/3/13.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Cordova/CDVViewController.h>
#import "CCCDVWebViewEngineProtocol.h"

@interface CCCDVViewController : CDVViewController <UIWebViewDelegate>
@property (nonatomic, readonly, strong) id <CCCDVWebViewEngineProtocol> webViewEngine;
@property (nonatomic, readwrite, strong) id <UIWebViewDelegate> navigationDelegate;
@end
