//
//  CCCipher.h
//  CCKit
//
//  Created by can on 2/9/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface CCCipher : NSObject
+ (instancetype)cipherWithAlgorithm:(CCAlgorithm)alg operation:(CCOperation)op options:(CCOptions)ops;
- (BOOL)init:(NSData *)key iv:(NSData *)iv;
- (BOOL)update:(NSData *)data;
- (NSData *)final;
@end
