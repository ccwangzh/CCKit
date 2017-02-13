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

- (void)testKeyItemPrivate {
    NSMutableDictionary *privateKeyQuery = [NSMutableDictionary new];
    privateKeyQuery[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassKey;
    privateKeyQuery[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.private";
    privateKeyQuery[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    CFDataRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKeyQuery, (CFTypeRef *)&dataRef);
    NSData *data = (__bridge_transfer NSData *)dataRef;
    
    if (status != errSecSuccess || data == nil) {
        [self testKeyItemGenerate];
        
        status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKeyQuery, (CFTypeRef *)&dataRef);
        data = (__bridge_transfer NSData *)dataRef;
    }
    
    NSString *privateKey = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"testKeyItemPrivate:%d, %@", status, privateKey);
}

- (void)testKeyItemPublic {
    NSMutableDictionary *publicKeyQuery = [NSMutableDictionary new];
    publicKeyQuery[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassKey;
    publicKeyQuery[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.public";
    publicKeyQuery[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    CFDataRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKeyQuery, (CFTypeRef *)&dataRef);
    NSData *data = (__bridge_transfer NSData *)dataRef;

    if (status != errSecSuccess || data == nil) {
        [self testKeyItemGenerate];
        
        status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKeyQuery, (CFTypeRef *)&dataRef);
        data = (__bridge_transfer NSData *)dataRef;
    }
    
    NSString *publicKey = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"testKeyItemPublic:%d, %@", status, publicKey);
}

- (void)testKeyItemGenerate {
    SecKeyRef publicKey = nil;
    SecKeyRef privateKey = nil;
    
    NSMutableDictionary *publicKeyParameters = [NSMutableDictionary new];
    publicKeyParameters[(__bridge NSString *)kSecAttrIsPermanent] = (__bridge id)kCFBooleanTrue;
    publicKeyParameters[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.public";
    
    NSMutableDictionary *privateKeyParameters = [NSMutableDictionary new];
    privateKeyParameters[(__bridge NSString *)kSecAttrIsPermanent] = (__bridge id)kCFBooleanTrue;
    privateKeyParameters[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.private";
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[(__bridge NSString *)kSecAttrKeyType] = (__bridge id)kSecAttrKeyTypeRSA;
    dictionary[(__bridge NSString *)kSecAttrKeySizeInBits] = @(1024);
    
    dictionary[(__bridge NSString *)kSecPublicKeyAttrs] = publicKeyParameters;
    dictionary[(__bridge NSString *)kSecPrivateKeyAttrs] = privateKeyParameters;
    
    OSStatus status = SecKeyGeneratePair((__bridge CFDictionaryRef)dictionary, &publicKey, &privateKey);
    
    NSLog(@"SecKeyGeneratePair:%d", status);
}

- (void)testKeyItemDestory {
    NSMutableDictionary *privateKeyQuery = [NSMutableDictionary new];
    privateKeyQuery[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassKey;
    privateKeyQuery[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.private";
    privateKeyQuery[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    NSMutableDictionary *publicKeyQuery = [NSMutableDictionary new];
    publicKeyQuery[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassKey;
    publicKeyQuery[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.public";
    publicKeyQuery[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    CFDataRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKeyQuery, (CFTypeRef *)&dataRef);
    NSData *data = (__bridge_transfer NSData *)dataRef;
    if (status == errSecSuccess || data != nil) {
        status = SecItemDelete((__bridge CFDictionaryRef)privateKeyQuery);
        
        NSLog(@"testKeyItemDestory-SecItemDelete-privateKeyQuery:%d", status);
    }
    
    SecItemCopyMatching((__bridge CFDictionaryRef)publicKeyQuery, (CFTypeRef *)&dataRef);
    data = (__bridge_transfer NSData *)dataRef;
    if (status == errSecSuccess || data != nil) {
        status = SecItemDelete((__bridge CFDictionaryRef)publicKeyQuery);
        
        NSLog(@"testKeyItemDestory-SecItemDelete-publicKeyQuery:%d", status);
    }
}

- (void)testKeyItemQuery {
    NSMutableDictionary *privateKeyQuery = [NSMutableDictionary new];
    privateKeyQuery[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassKey;
    privateKeyQuery[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.private";
    privateKeyQuery[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    NSMutableDictionary *publicKeyQuery = [NSMutableDictionary new];
    publicKeyQuery[(__bridge NSString *)kSecClass] = (__bridge id)kSecClassKey;
    publicKeyQuery[(__bridge NSString *)kSecAttrApplicationTag] = @"com.womob.pay.key.public";
    publicKeyQuery[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    CFDataRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKeyQuery, (CFTypeRef *)&dataRef);
    
    NSLog(@"testKeyItemQuery-SecItemCopyMatching-privateKeyQuery:%d", status);

    SecItemCopyMatching((__bridge CFDictionaryRef)publicKeyQuery, (CFTypeRef *)&dataRef);
    
    NSLog(@"testKeyItemQuery-SecItemCopyMatching-publicKeyQuery:%d", status);
    
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
    [self testPasswordItem];
    
//    [self testKeyItemGenerate];
//    [self testKeyItemQuery];
//    [self testKeyItemPrivate];
//    [self testKeyItemPublic];
//    [self testKeyItemDestory];
//    [self testKeyItemQuery];
}
@end
