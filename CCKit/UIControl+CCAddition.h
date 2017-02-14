//
//  UIControl+CCAddition.h
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (CCAddition)
- (void)setAction:(void (^)(UIControl *control, UIEvent *event))action
        forEvents:(UIControlEvents)events;
@end
