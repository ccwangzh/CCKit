//
//  CCTableViewTestKeychainCellModel.m
//  CCKit
//
//  Created by can on 17/2/10.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestKeychainCellModel.h"

#import "CCKeychain.h"

@implementation CCTableViewTestKeychainCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：钥匙串";
    }
    return self;
}

- (void)testKeyItemDigest {
    SecKeyRef publicKey = nil;
    SecKeyRef privateKey = nil;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[(__bridge NSString *)kSecAttrKeyType] = (__bridge id)kSecAttrKeyTypeRSA;
    dictionary[(__bridge NSString *)kSecAttrKeySizeInBits] = @(1024);
    
    OSStatus status = SecKeyGeneratePair((__bridge CFDictionaryRef)dictionary, &publicKey, &privateKey);
    
    NSLog(@"status:%d, %@, %@", status, publicKey, privateKey);
    
    NSString *plainText = @"YWFhYQ==";
    CFErrorRef errorRef = nil; NSData *signatureData = nil;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:plainText options:0];
    BOOL isSupport = SecKeyIsAlgorithmSupported(privateKey, kSecKeyOperationTypeSign, kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA1);
    NSLog(@"isSupport:%d", isSupport);
    if (isSupport) {
        signatureData = (__bridge_transfer NSData *)SecKeyCreateSignature(privateKey, kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA1, (__bridge CFDataRef)data, &errorRef);
        NSLog(@"signatureData:%@, error:%@", signatureData, errorRef);
    }
    
    isSupport = SecKeyIsAlgorithmSupported(publicKey, kSecKeyOperationTypeVerify, kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA1);
    NSLog(@"isSupport:%d", isSupport);
    if (isSupport) {
        BOOL isVerifyied = SecKeyVerifySignature(publicKey, kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA1, (__bridge CFDataRef)data, (__bridge CFDataRef)signatureData, &errorRef);
        NSLog(@"isVerifyied:%d", isVerifyied);
    }
    
}

- (void)testKeyItemCipher {
    SecKeyRef publicKey = nil;
    SecKeyRef privateKey = nil;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[(__bridge NSString *)kSecAttrKeyType] = (__bridge id)kSecAttrKeyTypeRSA;
    dictionary[(__bridge NSString *)kSecAttrKeySizeInBits] = @(1024);
    
    OSStatus status = SecKeyGeneratePair((__bridge CFDictionaryRef)dictionary, &publicKey, &privateKey);
    
    NSLog(@"status:%d, %@, %@", status, publicKey, privateKey);
    
    NSString *plainText = @"aGFsbG8=";
    CFErrorRef errorRef = nil; NSData *cipherData = nil; NSData *plainData = nil;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:plainText options:0];
    BOOL isSupport = SecKeyIsAlgorithmSupported(publicKey, kSecKeyOperationTypeEncrypt, kSecKeyAlgorithmRSAEncryptionPKCS1);
    NSLog(@"isSupport:%d", isSupport);
    if (isSupport) {
        cipherData = (__bridge_transfer NSData *)SecKeyCreateEncryptedData(publicKey, kSecKeyAlgorithmRSAEncryptionPKCS1, (__bridge CFDataRef)data, &errorRef);
        NSLog(@"cipherData:%@, error:%@", cipherData, errorRef);
    }
    
    isSupport = SecKeyIsAlgorithmSupported(privateKey, kSecKeyOperationTypeDecrypt, kSecKeyAlgorithmRSAEncryptionPKCS1);
    NSLog(@"isSupport:%d", isSupport);
    if (isSupport) {
        plainData = (__bridge_transfer NSData *)SecKeyCreateDecryptedData(privateKey, kSecKeyAlgorithmRSAEncryptionPKCS1, (__bridge CFDataRef)cipherData, &errorRef);
        NSLog(@"plainData:%@, error:%@", plainData, errorRef);
    }
    
    NSAssert([[plainData base64EncodedStringWithOptions:0] isEqualToString:plainText], @"plainData != cipherData");
}

- (void)testPasswordItem {
    CCSecGenericPasswordItem *gpi = [CCSecGenericPasswordItem new];
    gpi.account = @"ccwangzh";
    OSStatus status = 0;
    
    id object = nil;
    status = [gpi secGetOneObject:&object];
    if (status == errSecSuccess && object) {
        NSLog(@"status:%d,%@", status, object);
        status = [gpi secDelete];
        NSLog(@"status:%d", status);
        NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    }
    object = @"1234567890-no-acc-no-srv";
    status = [gpi secAddObject:object];
    NSLog(@"status:%d", status);
    NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    
    id result = nil;
    status = [gpi secGetOneObject:&result];
    NSLog(@"status:%d,%@", status, result);
    NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    NSAssert([result isEqualToString:object], @"status != errSecSuccess");
    
    status = [gpi secDelete];
    NSLog(@"status:%d", status);
    NSAssert(status == errSecSuccess, @"status != errSecSuccess");
    
    result = nil;
    status = [gpi secGetOneObject:&result];
    NSLog(@"status:%d,%@", status, result);
    NSAssert(status != errSecSuccess, @"status == errSecSuccess");
}

- (void)doTest {
    [self testKeyItemDigest];
}
@end
