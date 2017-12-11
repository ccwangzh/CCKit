//
//  CCCipher.h
//  CCSecurity
//
//  Created by ccwangzh on 2017/12/11.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface CCCipher : NSObject
+ (instancetype)cipherWithAlgorithm:(CCAlgorithm)alg operation:(CCOperation)op options:(CCOptions)ops;
- (BOOL)init:(NSData *)key iv:(NSData *)iv;
- (BOOL)update:(NSData *)data;
- (NSData *)final;
@end

