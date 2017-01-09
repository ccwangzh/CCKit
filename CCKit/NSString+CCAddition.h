//
//  NSString+CCAddition.h
//  CCKit
//
//  Created by can on 1/7/17.
//  Copyright © 2017 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCAddition)
- (BOOL)match:(NSString *)regular;
- (BOOL)isDigit;
- (BOOL)isPhone;
- (BOOL)isEmail;

- (NSString *)md5Value;
- (NSString *)sha1Value;
@end
