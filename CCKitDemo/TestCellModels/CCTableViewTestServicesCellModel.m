//
//  CCTableViewTestServicesCellModel.m
//  CCKit
//
//  Created by can on 17/5/11.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestServicesCellModel.h"

#import "CCTableViewTestNetworkingCellModel.h"

#import "CCViewController.h"
#import "CCNetworking.h"

#import "CCOperation.h"

@protocol CCTaskProtocol <NSObject>
@property (readonly, getter=isCancelled) BOOL cancelled;
@property (readonly, getter=isExecuting) BOOL executing;
@property (readonly, getter=isFinished) BOOL finished;
- (void)start;
- (void)cancel;
@end

@interface CCApiTask : NSObject <CCTaskProtocol>
{
    BOOL _cancelled;
    BOOL _executing;
    BOOL _finished;
}
@property (nonatomic) CCApiClient *client;
@property (nonatomic) CCHttpTask *task;
@property (nonatomic) id result;
@end

@interface CCGetTimeTask : CCApiTask

@end

@interface CCTestServicesViewController : CCViewController

@end

@interface CCTableViewTestServicesCellModel ()
@property (nonatomic, strong) CCApiTask *task;
@property (nonatomic) NSOperationQueue *queue;
@end

@implementation CCTableViewTestServicesCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Services";
        self.queue = [NSOperationQueue mainQueue];
        self.queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)setUp {
    self.task = [CCApiTask new];
    [self.task addObserver:self forKeyPath:@"cancelled" options:NSKeyValueObservingOptionNew context:NULL];
    
}

- (void)doTest {
    NSLog(@"doTest");

    CCOperation *op = [CCOperation new];
    [self.queue addOperation:op];
    NSLog(@"addOperation:%@", op);
    
    op = [CCOperation new];
    op.queuePriority = NSOperationQueuePriorityHigh;
    [self.queue addOperation:op];
    NSLog(@"addOperation:%@", op);

    [op cancel];

    op = [CCOperation new];
    op.queuePriority = NSOperationQueuePriorityVeryHigh;
    [self.queue addOperation:op];
    NSLog(@"addOperation:%@", op);
    
    [self.queue addOperationWithBlock:^{
        NSLog(@"aaa");
    }];
    
    op = [CCOperation new];
    op.queuePriority = NSOperationQueuePriorityVeryLow;
    [self.queue addOperation:op];
    NSLog(@"addOperation:%@", op);
    
    NSLog(@"addOperationWithBlock");

#if 0
    UIApplication *application = [UIApplication sharedApplication];
    UIViewController *rootController = [application keyWindow].rootViewController;
    UITabBarController *tabController = (UITabBarController *)rootController;
    UINavigationController *navController = [tabController selectedViewController];
    
    CCTestServicesViewController *testController = [CCTestServicesViewController new];
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
#endif
}

@end

@implementation CCTestServicesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
@end

@interface CCApiTask ()
@property (readwrite, getter=isCancelled) BOOL cancelled;
@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isFinished) BOOL finished;
@end

@implementation CCApiTask
@synthesize cancelled = _cancelled;
@synthesize executing = _executing;
@synthesize finished = _finished;
- (void)start {

}

- (void)cancel {
    self.cancelled = YES;
}

- (CCApiClient *)client {
    static CCApiClient *__client = nil;
    if (__client) {
        return __client;
    }
    __client = [CCApiClient apiClient];
    return __client;
}
@end

@implementation CCGetTimeTask
- (void)start {
    CCTimeRequest *request = [CCTimeRequest new];
    self.task = [self.client sendRequest:request completionHandler:^(CCHttpResponse *response, NSError *error) {
        
    }];
}
@end
