//
//  UIAlertView+CCAddition.m
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "UIAlertView+CCAddition.h"

#include <objc/runtime.h>

const void *kUIAlertViewClickHandlerAssociatedKey = &kUIAlertViewClickHandlerAssociatedKey;

@implementation UIAlertView (CCAddition)
- (void)setClickHandler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))clickHandler
{
    self.delegate = self;
    
    objc_setAssociatedObject(self, kUIAlertViewClickHandlerAssociatedKey, clickHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^clickHandler)(UIAlertView *alertView, NSInteger buttonIndex) = objc_getAssociatedObject(self, kUIAlertViewClickHandlerAssociatedKey);
    if (clickHandler) {
        clickHandler(alertView, buttonIndex);
    }
}

@end
