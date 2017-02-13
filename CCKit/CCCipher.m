//
//  CCCipher.m
//  CCKit
//
//  Created by can on 2/9/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import "CCCipher.h"

@interface CCCipher ()
@property (nonatomic, assign) CCCryptorRef cryptorRef;
@property (nonatomic, assign) CCAlgorithm algorithm;
@property (nonatomic, assign) CCOperation operation;
@property (nonatomic, assign) CCOptions options;
@property (nonatomic, strong) NSMutableData *outData;
@end

@implementation CCCipher
+ (instancetype)cipherWithAlgorithm:(CCAlgorithm)alg operation:(CCOperation)op options:(CCOptions)ops
{
    return [[self alloc] initWithAlgorithm:alg operation:op options:ops];
}


- (instancetype)initWithAlgorithm:(CCAlgorithm)alg operation:(CCOperation)op options:(CCOptions)ops
{
    if (self = [super init]) {
        _algorithm = alg;
        _operation = op;
        _options = ops;
        self.outData = [NSMutableData new];
    }
    return self;
}

- (BOOL)init:(NSData *)key
{
    CCCryptorRef cryptorRef = NULL;
    CCCryptorStatus status = kCCSuccess;
    status = CCCryptorCreate(_operation, _algorithm, _options, [key bytes], [key length], NULL, &cryptorRef);
    if (status != kCCSuccess || cryptorRef == NULL) {
        return NO;
    }
    _cryptorRef = cryptorRef;
    return YES;
}

- (BOOL)update:(NSData *)data
{
    if (_cryptorRef == NULL) {
        return NO;
    }
    size_t bufferSize = CCCryptorGetOutputLength(_cryptorRef, (size_t)[data length], false);
    void *bufferRef = malloc(bufferSize);
    if (bufferRef == NULL) {
        return NO;
    }
    
    size_t bufferUsedSize = 0;
    CCCryptorStatus status = kCCSuccess;
    status = CCCryptorUpdate(_cryptorRef, [data bytes], (size_t)[data length], bufferRef, bufferSize, &bufferUsedSize);
    if (status != kCCSuccess) {
        free(bufferRef);
        return NO;
    }
    [self.outData appendBytes:bufferRef length:bufferUsedSize];
    free(bufferRef);
    return YES;
}
- (NSData *)final
{
    if (_cryptorRef == NULL) {
        return nil;
    }
    size_t bufferSize = CCCryptorGetOutputLength(_cryptorRef, 0, true);
    void *bufferRef = malloc(bufferSize);
    if (bufferRef == NULL) {
        return nil;
    }
    
    size_t bufferUsedSize = 0;
    CCCryptorStatus status = kCCSuccess;
    status = CCCryptorFinal(_cryptorRef, bufferRef, bufferSize, &bufferUsedSize);
    if (status != kCCSuccess) {
        free(bufferRef);
        return nil;
    }
    [self.outData appendBytes:bufferRef length:bufferUsedSize];
    free(bufferRef);
    return self.outData;
}

-(void)dealloc
{
    if (_cryptorRef) {
        CCCryptorRelease(_cryptorRef);
        _cryptorRef = NULL;
    }
}
@end
