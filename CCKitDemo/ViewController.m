//
//  ViewController.m
//  CCKitDemo
//
//  Created by can on 2017/12/8.
//

#import "ViewController.h"

#import <CCAdditions/UIColor+CCAddition.h>
#import <CCAdditions/NSString+CCAddition.h>
#import <CCNetworking/CCNetworking.h>
#import <CCCommon/CCURLProtocol.h>
#import <CCSecurity/CCCipher.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor randomColor];
    NSLog(@"%@", [@"aad" md5Value]);
    [NSURLProtocol registerClass:[CCURLProtocol class]];
    CCCipher *c = [CCCipher cipherWithAlgorithm:kCCAlgorithm3DES operation:kCCEncrypt options: kCCOptionPKCS7Padding | kCCOptionECBMode];
    NSLog(@"%@", c);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
