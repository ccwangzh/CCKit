//
//  CCNetworking.m
//  CCKit
//
//  Created by can on 17/2/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCNetworking.h"

#import <AFNetworking/AFNetworking.h>

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
- (instancetype)initWithResponseObject:(id)responseObject {
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

- (void)suspend {
    [_sessionTask suspend];
}

- (void)resume {
    [_sessionTask resume];
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
    id requestHeaders = [request requestHeaders];
    
    Class responseClass = [request responseClass];
    
    NSError *serializationError = nil;
    AFHTTPSessionManager *manager = self.manager;
    dispatch_queue_t completionQueue = manager.completionQueue;
    AFHTTPRequestSerializer *requestSerializer = manager.requestSerializer;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:requestMethod URLString:requestUrl parameters:requestParameters error:&serializationError];
    if (serializationError) {
        if (completionHandler) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(completionQueue ?: dispatch_get_main_queue(), ^{
#ifdef DEBUG
                NSLog(@"\n{\nurl:%@,\nheaders:%@,\nparameters:%@,\nresult:%@}",requestUrl, urlRequest.allHTTPHeaderFields ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:urlRequest.allHTTPHeaderFields options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{}, requestParameters ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestParameters options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{}, serializationError);
#endif
                completionHandler(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    if (requestHeaders && [requestHeaders isKindOfClass:[NSDictionary class]]) {
        [requestHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [urlRequest setValue:[obj description] forHTTPHeaderField:[key description]];
        }];
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [manager dataTaskWithRequest:urlRequest uploadProgress:NULL downloadProgress:NULL completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
#ifdef DEBUG
        NSLog(@"\n{\nurl:%@,\nheaders:%@,\nparameters:%@,\nresult:%@}",requestUrl, urlRequest.allHTTPHeaderFields ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:urlRequest.allHTTPHeaderFields options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{}, requestParameters ? [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:requestParameters options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : @{}, responseObject ? [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding] : error);
#endif
        if (completionHandler) {
            id responseReturned = nil;
            if (responseClass && [responseObject isKindOfClass:[NSDictionary class]]) {
                responseReturned = [responseClass cc_modelWithDictionary:responseObject];
            }
            if (!responseReturned) {
                responseReturned = [[CCHttpResponse alloc] initWithResponseObject:responseObject];
            }
            completionHandler(responseReturned, error);
        }
    }];
    
    CCHttpTask *httpTask = [[CCHttpTask alloc] initWithSessionTask:dataTask];
    [httpTask resume];
    return httpTask;
}

@end

@interface CCApiRequest ()

@end

@implementation CCApiRequest
- (Class)responseClass {
    return [CCApiResponse class];
}
@end

@interface CCApiResponse ()

@end

@implementation CCApiResponse

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
        NSSet *oldSet = responseSerializer.acceptableContentTypes;
        NSSet *newSet = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        responseSerializer.acceptableContentTypes = [newSet setByAddingObjectsFromSet:oldSet];
    }
    return self;
}

@end







