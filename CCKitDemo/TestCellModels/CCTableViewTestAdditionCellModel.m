//
//  CCTableViewTestAdditionCellModel.m
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestAdditionCellModel.h"

#import "CCCipher.h"
#import "NSURL+CCAddition.h"
#import "NSString+CCAddition.h"
#import "UIControl+CCAddition.h"

#import <CommonCrypto/CommonCrypto.h>

#import <OpenSSL/sha.h>
#import <OpenSSL/aes.h>

NSString *VPAESEncrypt(NSString *token, NSString *seed, NSData *data);
NSData *VPAESDecrypt(NSString *token, NSString *seed, NSString *base64);
NSString *VPSHA256Sign(NSString *,NSString *,NSString *,NSString *,NSString *,NSString *);

@interface CCControl : UIControl

@end

@implementation CCControl
- (void)dealloc {
    NSLog(@"dealloc:%@", self);
}
@end

@interface CCTestViewController : UIViewController

@end

@implementation CCTestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CCControl *control = [CCControl new];
    [control setAction:^(UIControl *control, UIEvent *event) {
        NSLog(@"doAction");
    } forEvents:UIControlEventTouchUpInside];

    control.backgroundColor = [UIColor redColor];
    control.frame = CGRectMake(20, 100, 200, 50);
    [self.view addSubview:control];
}
@end

@interface Urls : NSObject
@property (nonatomic) NSString *url;
@end

@implementation Urls
@synthesize url = _url;
- (void)setUrl:(NSString *)url {
    if (__status == 0) {
        __url = url;
        return;
    }
    if ([url hasPrefix:@"http"]) {
        if (__status == 1) {
            __url = url;
        }
    } else {
        if (__status == 2) {
            __url = url;
        }
    }
}
static char __status;
static NSString *__url;
- (NSString *)url {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([__url hasPrefix:@"http"]) {
            __status = 1;
        } else {
            __status = 2;
        }
    });
    return __url;
}

@end

@implementation CCTableViewTestAdditionCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：扩展";
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
    
    Urls *urls = [Urls new];
    urls.url = @"http://www.baidu.com/1";
    NSLog(@"url:%@", urls.url);
    
    urls = [Urls new];
    urls.url = @"vipjr://login";
    NSLog(@"url:%@", urls.url);
    
    urls = [Urls new];
    urls.url = @"http://www.baidu.com/2";
    NSLog(@"url:%@", urls.url);
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com:8080/a/?k=v"];
    NSLog(@"%@", [url queryDictionary]);
    NSLog(@"%@", [url URLByReplacingQueryDictionary:@{@"k1":@"v1.", @"k3":@"v3"}]);
    NSLog(@"%@", [url URLByAppendingQueryDictionary:@{@"k1":@"v1.", @"k3":@"v3"}]);
    
    NSLog(@"%@", [url URLByRemovingAllQueryItems]);
}

- (void)doTest3 {
    NSLog(@"doTest");
    
    NSString *token = @"S2f4q1Ga4qsWg7q9JbfanjpAynYFJAK2HKkt";
    NSString *seed = @"qfLilkuKh1eVgSU9fDOhaWrYM3TqExtTLWW448fPxW1mkVs5Et5kQBWpWcaH";
    NSData *data = [@"abcdefghijklmnopr" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encryptString = VPAESEncrypt(token, seed, data);
    NSLog(@"encryptString:%@", encryptString);
    NSData *decryptData = VPAESDecrypt(token, seed, encryptString);
    NSLog(@"decryptData:%@", [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding]);
    
    
    NSString *e = @"{\"df\":\"123456\",\"db\":\"iPhone 7\",\"net\":\"4g\",\"nettype\":\"FDD-LTE\",\"os\":\"iOs\",\"ov\":\"10.3.0\",\"ver\":\"1.0.0\",\"gps\":\"121.4737,31.2304\"}";
    
    NSString *pt = @"PQ";
    
    NSString *ptid = @"yTvkuzoRDsDQWBx1fUSxdAY=";
    
    NSString *cv = @"0|1.0.0|xxxxxxxxx";
    
    NSString *ts = @"1501642959970";
    
    NSString *secret = @"qfLilkuKh1eVgSU9fDOhaWrYM3TqExtTLWW448fPxW1mkVs5Et5kQBWpWcaH";
    
    NSString *sign = VPSHA256Sign(e, pt, ptid, cv, ts, secret);
    
    NSLog(@"sign:%@", sign);
}

- (void)doTest2 {
    NSLog(@"doTest");
    
    char *token = "S2f4q1Ga4qsWg7q9JbfanjpAynYFJAK2HKkt";
    size_t token_length = strlen(token);
    
    char *seed = "qfLilkuKh1eVgSU9fDOhaWrYM3TqExtTLWW448fPxW1mkVs5Et5kQBWpWcaH";
    size_t seed_length = strlen(seed);
    
    size_t concat_length = token_length + seed_length;
    unsigned char *concat = malloc(concat_length + 1);
    memcpy(concat, token, token_length);
    memcpy(concat + token_length, seed, seed_length);
    memset(concat + concat_length, '\0', 1);
    
    printf("%s\n", concat);
    
    unsigned char sha256[33] = {0};
    
    SHA256(concat, concat_length, sha256);
    
    printf("%s\n", sha256);
    
    char encrypt_string[4096] = { 0 };
    
    AES_KEY aes;
    
    char key[17] = {0};
    char iv[17] = {0};
    
    memcpy(key, sha256, 16);
    memcpy(iv, sha256 + 16, 16);
    
    
    char *input_string = "6201343487230914324";
    size_t nLen = strlen(input_string);
    
    
    size_t nBei = nLen / AES_BLOCK_SIZE + 1;
    size_t nTotal = nBei * AES_BLOCK_SIZE;
    char *enc_s = (char*)malloc(nTotal);
    size_t nNumber;
    if (nLen % 16 > 0)
        nNumber = nTotal - nLen;
    else
        nNumber = 16;
    memset(enc_s, nNumber, nTotal);
    memcpy(enc_s, input_string, nLen);
    
    NSLog(@"%@", [NSData dataWithBytes:enc_s length:nTotal]);
    
    if (AES_set_encrypt_key((unsigned char*)key, 128, &aes) < 0) {
        fprintf(stderr, "Unable to set encryption key in AES\n");
        exit(-1);
    }
    
    AES_cbc_encrypt((unsigned char *)enc_s, (unsigned char*)encrypt_string, nBei * 16, &aes, (unsigned char*)iv, AES_ENCRYPT);
    
    NSData *data = [NSData dataWithBytes:encrypt_string length:nBei * 16];
    
    NSLog(@"data:%@,%@", data, [data base64EncodedStringWithOptions:0]);

}

- (void)doTest1 {
    NSLog(@"doTest");
    
    // APP 访问 token
    NSString *token = @"S2f4q1Ga4qsWg7q9JbfanjpAynYFJAK2HKkt";
    
    // 二维码密钥种子
    NSString *seed = @"qfLilkuKh1eVgSU9fDOhaWrYM3TqExtTLWW448fPxW1mkVs5Et5kQBWpWcaH";
    
    // 需要加密的数据
    NSString *plain = @"6201343487230914324";
    
    NSString *concat = [NSString stringWithFormat:@"%@%@", token, seed];
    
    const char *str = concat.UTF8String;
    unsigned char r[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), r);
    
    NSString *sha256 = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15], r[16], r[17], r[18], r[19], r[20], r[21], r[22], r[23], r[24], r[25], r[26], r[27], r[28], r[29], r[30], r[31]];
    NSLog(@"sha256:%@", sha256);
    
    NSData *inData = [plain dataUsingEncoding:NSUTF8StringEncoding];
    NSData *key = [NSData dataWithBytes:r length:16];
    NSData *iv = [NSData dataWithBytes:r+16 length:16];
    
    NSLog(@"%@,%@", key, iv);
    
    const void *key_ptr = [key bytes];
    size_t key_length = [key length];
    
    const void *iv_ptr = [iv bytes];
    
    const void *in_ptr = [inData bytes];
    size_t in_length = [inData length];
    
    size_t out_length = 1024;
    void *out_ptr = malloc(out_length);
    
    size_t out_moved = 0;
    
    CCCryptorStatus status =  CCCrypt(kCCEncrypt,
                                      kCCAlgorithmAES128,
                                      kCCOptionPKCS7Padding,
                                      key_ptr,
                                      key_length,
                                      iv_ptr,
                                      in_ptr,
                                      in_length,
                                      out_ptr,
                                      out_length,
                                      &out_moved);
    
    NSData *outData = [NSData dataWithBytes:out_ptr length:out_moved];
    NSLog(@"%@", [outData base64EncodedStringWithOptions:0]);
    
    NSLog(@"status:%d,%lu", status, out_moved);
    
    CCCipher *ciper = [CCCipher cipherWithAlgorithm:kCCAlgorithmAES128 operation:kCCEncrypt options:kCCOptionPKCS7Padding | kCCOptionECBMode];
    [ciper init:key iv:iv];
    [ciper update:[plain dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [ciper final];
    
    NSString *string_ok = @"AOSqt0I4hLEWLOdhbmvzyTvkuzoRDsDQWBx1fUSxdAY";
    NSString *string_base64 = [data base64EncodedStringWithOptions:0];
    
    NSLog(@"ok:%d, %@", [string_base64 isEqualToString:string_ok],string_base64);
    
}
@end

NSString *VPAESEncrypt(NSString *token, NSString *seed, NSData *data) {
    if (!token || !seed || !data) return nil;
    
    NSMutableData *stringData = [NSMutableData new];
    [stringData appendData:[token dataUsingEncoding:NSUTF8StringEncoding]];
    [stringData appendData:[seed dataUsingEncoding:NSUTF8StringEncoding]];
    
    const unsigned char *string_ptr = [stringData bytes];
    size_t string_len = [stringData length];
    
    unsigned char md_ptr[33] = {0};
    SHA256(string_ptr, string_len, md_ptr);
    
    unsigned char key[17] = {0};
    unsigned char iv[17] = {0};
    memcpy(key, md_ptr, 16);
    memcpy(iv, md_ptr + 16, 16);
    
    const unsigned char *data_ptr = [data bytes];
    size_t data_len = [data length];
    
    size_t block_cnt = data_len / AES_BLOCK_SIZE + 1;
    size_t block_size = block_cnt * AES_BLOCK_SIZE;
    
    unsigned char *block_ptr = malloc(block_size);
    size_t padding = data_len % 16 ? block_size - data_len : 16;
    memset(block_ptr, padding, block_size);
    memcpy(block_ptr, data_ptr, data_len);
    
    AES_KEY aes_key;
    if (AES_set_encrypt_key(key, 128, &aes_key) < 0) {
        if (block_ptr) free(block_ptr);
        return nil;
    }
    
    unsigned char *encrypt_ptr = malloc(block_size);
    AES_cbc_encrypt(block_ptr, encrypt_ptr, block_size, &aes_key, iv, AES_ENCRYPT);
    
    NSData *encryptData = [NSData dataWithBytes:encrypt_ptr length:block_size];
    if (encrypt_ptr) free(encrypt_ptr);
    if (block_ptr) free(block_ptr);
    
    return [encryptData base64EncodedStringWithOptions:0];
}

NSData *VPAESDecrypt(NSString *token, NSString *seed, NSString *base64) {
    if (!token || !seed || !base64) return nil;
    
    NSMutableData *stringData = [NSMutableData new];
    [stringData appendData:[token dataUsingEncoding:NSUTF8StringEncoding]];
    [stringData appendData:[seed dataUsingEncoding:NSUTF8StringEncoding]];
    
    const unsigned char *string_ptr = [stringData bytes];
    size_t string_len = [stringData length];
    
    unsigned char md_ptr[33] = {0};
    SHA256(string_ptr, string_len, md_ptr);
    
    unsigned char key[17] = {0};
    unsigned char iv[17] = {0};
    memcpy(key, md_ptr, 16);
    memcpy(iv, md_ptr + 16, 16);
    
    NSDataBase64DecodingOptions opts = NSDataBase64DecodingIgnoreUnknownCharacters;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:opts];
    const unsigned char *data_ptr = [data bytes];
    size_t data_len = [data length];
    
    AES_KEY aes_key;
    if (AES_set_decrypt_key(key, 128, &aes_key) < 0) {
        return nil;
    }
    
    unsigned char *decrypt_ptr = malloc(data_len);
    AES_cbc_encrypt(data_ptr, decrypt_ptr, data_len, &aes_key, iv, AES_DECRYPT);
    
    unsigned char padding = decrypt_ptr[data_len - 1];
    
    NSData *decryptData = [NSData dataWithBytes:decrypt_ptr length:data_len - padding];
    if (decrypt_ptr) free(decrypt_ptr);
    
    return decryptData;
}

NSString *VPSHA256Sign(NSString *e, NSString *pt, NSString *ptid, NSString *cv, NSString *ts, NSString *seed) {
    NSMutableString *string = [NSMutableString new];
    if (e && e.length) {
        [string appendString:e];
    }
    
    if (pt && pt.length) {
        [string appendString:@"$"];
        [string appendString:pt];
    }
    
    if (ptid && ptid.length) {
        [string appendString:@"$"];
        [string appendString:ptid];
    }
    
    if (cv && cv.length) {
        [string appendString:@"$"];
        [string appendString:cv];
    }
    
    if (ts && ts.length) {
        [string appendString:@"$"];
        [string appendString:ts];
    }
    
    if (seed && seed.length) {
        [string appendString:@"$"];
        [string appendString:seed];
    }
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *string_ptr = [stringData bytes];
    size_t string_len = [stringData length];
    
    unsigned char md_ptr[33] = {0};
    SHA256(string_ptr, string_len, md_ptr);
    
    NSData *data = [NSData dataWithBytes:md_ptr length:32];
    
    return [data base64EncodedStringWithOptions:0];
}
