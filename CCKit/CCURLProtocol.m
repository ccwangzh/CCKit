//
//  CCURLProtocol.m
//  CCKit
//
//  Created by can on 17/3/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCURLProtocol.h"

#define kCCPropertyKey       @"kCCPropertyKey"
#define kCCPropertyValue     @"1"

@interface CCURLProtocol ()
<NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end

@implementation CCURLProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    id a = [NSURLProtocol propertyForKey:kCCPropertyKey inRequest:request];
    NSLog(@"canInitWithRequest:%@,%@", request, a);
    if (a) {
        return NO;
    }
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSLog(@"canonicalRequestForRequest:%@", request);

    NSMutableURLRequest *mutableRequest = nil;
    if ([request isKindOfClass:[NSMutableURLRequest class]]) {
        mutableRequest  = (NSMutableURLRequest *)request;
    } else {
        mutableRequest = [request mutableCopy];
    }
    [NSURLProtocol setProperty:kCCPropertyValue forKey:kCCPropertyKey inRequest:mutableRequest];
    return mutableRequest;
}

- (void)startLoading {
    NSLog(@"startLoading:%@", self.request);
    
    NSURLSessionConfiguration *sc = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sc delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    self.dataTask = [session dataTaskWithRequest:self.request];
    [self.dataTask resume];
}

- (void)stopLoading {
    [self.dataTask cancel];
    self.dataTask = nil;
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        [[self client] URLProtocol:self didFailWithError:error];
    } else {
        [[self client] URLProtocolDidFinishLoading:self];
    }
}

@end
