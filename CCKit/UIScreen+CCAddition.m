//
//  UIScreen+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "UIScreen+CCAddition.h"

@implementation UIScreen (CCAddition)
+ (CGFloat)mainScreenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)mainScreenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)mainScreenScale {
    return [[UIScreen mainScreen] scale];
}

+ (CGSize)mainScreenSize {
    return [[UIScreen mainScreen] bounds].size;
}
@end
