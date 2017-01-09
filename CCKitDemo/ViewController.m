//
//  ViewController.m
//  CCKitDemo
//
//  Created by can on 17/1/3.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "ViewController.h"

#import "UIAlertView+CCAddition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"aaa" message:@"bbb" delegate:self cancelButtonTitle:@"cc" otherButtonTitles:@"dd", @"ee", nil];
    [alertView setClickHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        NSLog(@"buttonIndex:%ld", buttonIndex);
    }];
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
