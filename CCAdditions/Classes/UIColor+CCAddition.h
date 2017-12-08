//
//  UIColor+CCAddition.h
//  CCAdditions
//
//  Created by ccwangzh on 2017/12/8.
//

#import <UIKit/UIKit.h>

@interface UIColor (CCAddition)
+ (UIColor *)randomColor;
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;
+ (UIColor *)colorWithRGBA:(NSUInteger)rgba;
+ (UIColor *)colorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b;
+ (UIColor *)colorWithR:(NSUInteger)r g:(NSUInteger)g b:(NSUInteger)b a:(NSUInteger)a;
@end
