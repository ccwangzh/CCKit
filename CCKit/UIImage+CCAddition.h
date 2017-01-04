//
//  UIImage+CCAddition.h
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CCAddition)

/**
 *  纯色图片  例: [UIImage imageWithColor:[UIColor whiteColor]]
 *  @param color 如 [UIColor whiteColor]
 *  @return UIImage instance
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  纯色图片  例: [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(2, 2)]
 *  @param color 如 [UIColor whiteColor]
 *  @param size  如 CGSizeMake(2, 2)
 *  @return UIImage instance
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
