//
//  ViewController.m
//  CCKitReact
//
//  Created by can on 17/9/1.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "ViewController.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *jsCodeLocation;
    
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RootView"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    rootView.frame = self.view.bounds;
    [self.view addSubview:rootView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
