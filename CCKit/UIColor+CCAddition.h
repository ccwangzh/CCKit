//
//  UIColor+CCAddition.h
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CCAddition)

/**
 *  16进制颜色  例: [UIColor colorWithRGB:0xFF0000]
 *  @param rgb 如 0xFFFFFF 对应白色
 *  @return UIColor instance
 */
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;

/**
 *  16进制颜色  例: [UIColor colorWithRGB:0xFF000000]
 *  @param rgba 如 0xFFFFFF00 对应白色
 *  @return UIColor instance
 */
+ (UIColor *)colorWithRGBA:(NSUInteger)rgba;

/**
 *  10进制颜色  例: [UIColor colorWithR:111 g:112 b:113]
 *  @param r 如 111 对应红色色值
 *  @param g 如 112 对应绿色色值
 *  @param b 如 113 对应蓝色色值
 *  @return UIColor instance
 */
+ (UIColor *)colorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b;

/**
 *  10进制颜色  例: [UIColor colorWithR:111 g:112 b:113 a:255]
 *  @param r 如 111 对应红色色值
 *  @param g 如 112 对应绿色色值
 *  @param b 如 113 对应蓝色色值
 *  @param a 如 255 对应透明色值
 *  @return UIColor instance
 */
+ (UIColor *)colorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b a:(NSUInteger)a;

/**
 *  返回随机颜色
 */
+ (UIColor *)randomColor;
@end
