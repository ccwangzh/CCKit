//
//  CCTableViewTestExamplesCellModel.m
//  CCKit
//
//  Created by can on 17/6/26.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestExamplesCellModel.h"

@interface CCTableViewTestExamplesViewController : UIViewController
@property (nonatomic) UIScrollView *contentView;
@property (nonatomic) UITextField *textField;
@end

@interface CCTableViewTestExamplesCellModel ()

@end

@implementation CCTableViewTestExamplesCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Examples";
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
    UIApplication *application = [UIApplication sharedApplication];
    UIViewController *rootController = [application keyWindow].rootViewController;
    UITabBarController *tabController = (UITabBarController *)rootController;
    UINavigationController *navController = [tabController selectedViewController];
    
    CCTableViewTestExamplesViewController *testController = nil;
    testController = [CCTableViewTestExamplesViewController new];
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}
@end

@implementation CCTableViewTestExamplesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat y = 0;
    if (!_contentView) {
        _contentView = [UIScrollView new];
    }
    UIView *contentView = _contentView;
    contentView.frame = self.view.bounds;
    [self.view addSubview:contentView];
    
    if (!_textField) {
        _textField = [UITextField new];
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _textField.frame = CGRectMake(0, y, width, 33.0f);
    _textField.placeholder = @"请输入";
    _textField.borderStyle = UITextBorderStyleLine;
    [contentView addSubview:_textField];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
