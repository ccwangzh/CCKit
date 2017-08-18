//
//  CCTableViewTestAdditionCellModel.m
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestAdditionCellModel.h"

#import "CCCipher.h"
#import "NSString+CCAddition.h"
#import "UIControl+CCAddition.h"

#import <CommonCrypto/CommonCrypto.h>

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

@implementation CCTableViewTestAdditionCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：扩展";
    }
    return self;
}
- (void)doTest {
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
    
    NSLog(@"%@", [data base64EncodedStringWithOptions:0]);
    
}
@end
