//
//  CCTableViewTestAdditionCellModel.m
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestAdditionCellModel.h"

#import "UIControl+CCAddition.h"

@interface CCControl : UIControl

@end

@implementation CCControl
- (void)dealloc {
    NSLog(@"dealloc:%@", self);
}
@end

@interface CCTestViewController : UIViewController

@end

@implementation CCTestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CCControl *control = [CCControl new];
    [control setAction:^(UIControl *control, UIEvent *event) {
        NSLog(@"doAction");
    } forEvents:UIControlEventTouchUpInside];

    control.backgroundColor = [UIColor redColor];
    control.frame = CGRectMake(20, 100, 200, 50);
    [self.view addSubview:control];
}
@end

@implementation CCTableViewTestAdditionCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：扩展";
    }
    return self;
}
- (void)doTest {
    NSLog(@"doTest");
}
@end
