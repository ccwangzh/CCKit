//
//  CCViewController.m
//  CCKit
//
//  Created by can on 17/1/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCViewController.h"
#include <objc/runtime.h>

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end

@implementation UIViewController (CCViewControllerCustomize)
@dynamic customizeInfo, customizeBackButton;
const void *kUIViewControllerCustomizeInfoAssociatedKey = &kUIViewControllerCustomizeInfoAssociatedKey;
- (NSMutableDictionary *)customizeInfo {
    NSMutableDictionary *_info = objc_getAssociatedObject(self, kUIViewControllerCustomizeInfoAssociatedKey);
    if (_info) return _info;
    _info = [NSMutableDictionary new];
    objc_setAssociatedObject(self, kUIViewControllerCustomizeInfoAssociatedKey, _info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return _info;
}
- (UIBarButtonItem *)customizeBackButton {
    return [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(customizeBackAction:)];
}
- (void)customizeBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
