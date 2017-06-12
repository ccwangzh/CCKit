//
//  ViewController.m
//  CCKitSDK
//
//  Created by can on 17/6/12.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"open" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    button.frame = CGRectMake(100, 50, 100, 44);
    [button addTarget:self action:@selector(openButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)openButtonDidClicked:(id)sender {
    NSURL *url = [NSURL URLWithString:@"cckitdemo://open"];
    NSDictionary *options = [NSDictionary new];
    [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {
        
    }];
}


@end
