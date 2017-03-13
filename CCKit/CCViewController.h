//
//  CCViewController.h
//  CCKit
//
//  Created by can on 17/1/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCViewController : UIViewController

@end

@interface UIViewController (CCViewControllerCustomize)
@property (nonatomic, readonly) NSMutableDictionary *customizeInfo;
@property (nonatomic, readonly) UIBarButtonItem *customizeBackButton;
- (void)customizeBackAction:(id)sender;
@end
