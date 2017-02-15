//
//  CCRouter.m
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCRouter.h"

@implementation CCRouter

@end

@implementation CCRouteRule

@end

@implementation CCRouteHandler

@end

@interface CCRouteManager ()
@property (nonatomic) NSMutableArray *routers;
@end

@implementation CCRouteManager
+ (instancetype)manager {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL)addHandler:(CCRouteHandler *)handler forRule:(CCRouteRule *)rule {
    return NO;
}



@end
