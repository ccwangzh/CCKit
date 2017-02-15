//
//  CCRouter.h
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCRouter : NSObject

@end

@interface CCRouteRule : NSObject

@end

@interface CCRouteHandler : NSObject

@end

@interface CCRouteManager : NSObject
+ (instancetype)manager;
@end
