//
//  CCNetworking.h
//  CCKit
//
//  Created by can on 17/2/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+CCModel.h"

@class CCHttpTask;
@class CCHttpRequest;
@class CCHttpResponse;
typedef void(^CCHttpCompletionHandler)(CCHttpResponse *response, NSError *error);

@interface CCHttpClient : NSObject
+ (instancetype)httpClient;
- (CCHttpTask *)sendRequest:(CCHttpRequest *)request
          completionHandler:(CCHttpCompletionHandler)completionHandler;
@end

@interface CCHttpRequest : NSObject
- (NSString *)requestUrl;
- (NSString *)requestMethod;

- (id)requestHeaders;
- (id)requestParameters;

- (Class)responseClass;
@end

@interface CCHttpResponse : NSObject
- (id)responseObject;
@end

@interface CCHttpTask : NSObject
- (void)cancel;
@end

@interface CCApiClient : CCHttpClient
+ (instancetype)apiClient;
@end
