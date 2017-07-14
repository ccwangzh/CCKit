//
//  NSDate+CCAddition.m
//  CCKit
//
//  Created by can on 17/7/11.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "NSDate+CCAddition.h"

@implementation NSDate (CCAddition)
- (NSString *)timestamp {
    return [NSString stringWithFormat:@"%ld", (long)self.timeIntervalSince1970];
}
@end
