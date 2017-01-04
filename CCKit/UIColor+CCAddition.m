//
//  UIColor+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "UIColor+CCAddition.h"

@implementation UIColor (CCAddition)
+ (UIColor *)colorWithRGB:(NSUInteger)rgb {
    unsigned char r, g, b;
    b = rgb & 0xFF;
    g = (rgb >> 8) & 0xFF;
    r = (rgb >> 16) & 0xFF;
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}

+ (UIColor *)colorWithRGBA:(NSUInteger)rgba {
    unsigned char r, g, b, a;
    b = rgba & 0xFF;
    g = (rgba >> 8) & 0xFF;
    r = (rgba >> 16) & 0xFF;
    a = (rgba >> 24) & 0xFF;
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

+ (UIColor *)colorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
}

+ (UIColor *)colorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b alpha:(NSUInteger)a {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

@end
