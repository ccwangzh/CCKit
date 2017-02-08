//
//  CCNetworking.m
//  CCKit
//
//  Created by can on 17/2/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCNetworking.h"

#import <AFNetworking/AFNetworking.h>

typedef void(^CCHttpSuccessCompletionHandler)(NSURLSessionDataTask *task, id responseObject);
typedef void(^CCHttpFailureCompletionHandler)(NSURLSessionDataTask *task, NSError *error);

@implementation CCHttpRequest
- (NSString *)requestUrl {
    return nil;
}

- (NSString *)requestMethod {
    return @"GET";
}

- (id)requestHeaders {
    return nil;
}

- (id)requestParameters {
    return [self cc_modelToJSONObject];
}

- (Class)responseClass {
    return nil;
}
@end

@interface CCHttpResponse ()
{
    __strong id _responseObject;
}
@end

@implementation CCHttpResponse
- (instancetype)initWithSessionResponse:(id)responseObject {
    if (self = [super init]) {
        _responseObject = responseObject;
    }
    return self;
}
- (id)responseObject {
    return _responseObject;
}
@end


@interface CCHttpTask ()
{
    __strong NSURLSessionTask *_sessionTask;
}
@end

@implementation CCHttpTask
- (instancetype)initWithSessionTask:(NSURLSessionTask *)sessionTask {
    if (self = [super init]) {
        _sessionTask = sessionTask;
    }
    return self;
}
- (void)cancel {
    [_sessionTask cancel];
}
@end

@interface CCHttpClient ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation CCHttpClient
+ (instancetype)httpClient {
    return [[self alloc] init];
}

- (id)init {
    if (self=[super init]) {
        self.manager = [[AFHTTPSessionManager alloc] init];
    }
    return self;
}

- (CCHttpTask *)sendRequest:(CCHttpRequest *)request
          completionHandler:(CCHttpCompletionHandler)completionHandler {
    
    NSAssert(request != nil, @"request == nil");
    
    NSString *requestMethod = [request requestMethod];
    NSString *requestUrl = [request requestUrl];
    
    NSAssert(requestMethod != nil, @"requestMethod == nil");
    NSAssert(requestUrl != nil, @"requestUrl == nil");
    
    id requestParameters = [request requestParameters];
    Class responseClass = [request responseClass];
    
    CCHttpSuccessCompletionHandler __successCompletionHandler = ^(NSURLSessionDataTask *task, id responseObject) {
#ifdef DEBUG
        NSLog(@"\nrequest:{\n\turl:%@\n\n\tparameters:%@\n}\nresponse:%@", task.originalRequest.URL, requestParameters ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestParameters options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{}, responseObject ? [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{});
#endif
        id responseReturned = nil;
        if (responseClass && [responseObject isKindOfClass:[NSDictionary class]]) {
            responseReturned = [responseClass cc_modelWithDictionary:responseObject];
        }
        if (!responseReturned) {
            responseReturned = [[CCHttpResponse alloc] initWithSessionResponse:responseObject];
        }
        if (completionHandler) {
            completionHandler(responseReturned, nil);
        }
    };
    
    CCHttpFailureCompletionHandler __failureCompletionHandler = ^(NSURLSessionDataTask *task, NSError *error) {
#ifdef DEBUG
        NSLog(@"\nrequest:{\n\turl:%@\n\n\tparameters:%@\n}\nerror:%@", task.originalRequest.URL, requestParameters ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestParameters options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{}, error);
#endif
        if (completionHandler) {
            completionHandler(nil, error);
        }
    };
    
    NSURLSessionDataTask *task = nil;
    if ([requestMethod isEqualToString:@"GET"]) {
        task = [self.manager GET:requestUrl parameters:requestParameters
                        progress:NULL success:__successCompletionHandler failure:__failureCompletionHandler];
    } else if ([requestMethod isEqualToString:@"POST"]) {
        task = [self.manager POST:requestUrl parameters:requestParameters
                         progress:NULL success:__successCompletionHandler failure:__failureCompletionHandler];
    }
    
    return [[CCHttpTask alloc] initWithSessionTask:task];
}

@end

@interface CCApiClient ()

@end

@implementation CCApiClient
+ (instancetype)apiClient {
    return [[self alloc] init];
}

- (id)init {
    if (self = [super init]) {
        AFHTTPSessionManager *manager = self.manager;
        AFHTTPResponseSerializer *responseSerializer = manager.responseSerializer;
        NSSet *acceptableContentTypes = [responseSerializer acceptableContentTypes];
        NSMutableSet *mutableSet = nil;
        if (acceptableContentTypes) {
            mutableSet = [acceptableContentTypes mutableCopy];
        } else {
            mutableSet = [NSMutableSet new];
        }
        [mutableSet addObject:@"text/plain"];
        [mutableSet addObject:@"text/html"];
        responseSerializer.acceptableContentTypes = mutableSet;
    }
    return self;
}

@end







