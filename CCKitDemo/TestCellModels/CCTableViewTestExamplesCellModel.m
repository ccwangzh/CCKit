//
//  CCTableViewTestExamplesCellModel.m
//  CCKit
//
//  Created by can on 17/6/26.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "NSString+CCAddition.h"
#import "NSDate+CCAddition.h"
#import "CCTableViewTestExamplesCellModel.h"

NSString *VFWapLifeUrl(NSString *userId, NSString *channel);

@interface CCTableViewTestExamplesViewController : UIViewController
@property (nonatomic) UIScrollView *contentView;
@property (nonatomic) UITextField *textField;
@end

@interface CCTableViewTestExamplesCellModel () <CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *location;
@property (nonatomic) void (^completion)(void);
@end

@implementation CCTableViewTestExamplesCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Examples";
    }
    return self;
}

- (void)doTest {
    NSString *url = VFWapLifeUrl(@"669F7A66A7A554AF1A8929AA44B93A8A", @"chongzhi");
    
    NSLog(@"%@", url);
}

- (void)doTest3 {
    NSLog(@"doTest");
    NSString *a = nil;
    NSLog(@"%@", a ? : @"b");
    
    [self.locationManager requestLocation];
}

- (void)doTest2 {
    NSLog(@"doTest");
    [[[UIAlertView alloc] initWithTitle:@"b" message:@"b" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        static UIWindow *window = nil;
        window = [UIWindow new];
        window.windowLevel = UIWindowLevelAlert;
        window.backgroundColor = [UIColor redColor];
        window.frame = [UIScreen mainScreen].bounds;
        [window makeKeyAndVisible];
        
        NSLog(@"%f,%f,%f", UIWindowLevelAlert, UIWindowLevelNormal, UIWindowLevelStatusBar);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(50 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            window = nil;
            [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"a" message:@"a" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        });
    });
}

- (void)doTest1 {
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

- (void)requestLocationWithCompletion:(void (^)(NSArray<CLLocation *> *locations, NSError *error))completion {
    
}

- (CLLocationManager *)locationManager {
    if (_locationManager) {
        return _locationManager;
    }
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 100.0f;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManager requestWhenInUseAuthorization];
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager:%@,%@", manager, error);
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locationManager:%@,%@", manager, locations);
    [self.locationManager stopUpdatingLocation];
}

@end

NSString *VFWapLifeUrl(NSString *userId, NSString *channel) {
    NSString *appKey = @"2512160231";
    NSString *appSecret = @"PqKTDyz1VcZwBMoaXSTcnwQmqBH8pIeE";
    NSString *userPhone = @"";
    NSString *timestamp = [[NSDate new] timestamp];
    
    NSMutableString *string = [NSMutableString new];
    [string appendString:appKey];
    [string appendString:userId];
    [string appendString:userPhone];
    [string appendString:timestamp];
    [string appendString:appSecret];
    
    NSString *sign = [string md5Value];
    
    NSMutableString *url = [NSMutableString new];
    [url appendFormat:@"http://vipjinrong.test.otosaas.com/"];
    [url appendFormat:@"%@/?", channel];
    
    
    [url appendFormat:@"customerUserId=%@", userId];
    [url appendFormat:@"&customerUserPhone=%@", userPhone];
    [url appendFormat:@"&timestamp=%@", timestamp];
    [url appendFormat:@"&appKey=%@", appKey];
    [url appendFormat:@"&sign=%@", sign];
    return url;
}

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
