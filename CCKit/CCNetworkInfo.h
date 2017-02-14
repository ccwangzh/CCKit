//
//  CCNetworkInfo.h
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

typedef NS_ENUM(NSInteger, CCNetworkType) {
    CCNetworkTypeNone = 0,
    CCNetworkTypeWWAN = 1,
    CCNetworkTypeWiFi = 2,
};

typedef NS_ENUM(NSInteger, CCNetworkWWANType) {
    CCNetworkWWANType2G = 2,
    CCNetworkWWANType3G = 3,
    CCNetworkWWANType4G = 4,
    CCNetworkWWANTypeUnkown = 0,
};

@interface CCNetworkInfo : NSObject
+ (instancetype)networkInfo;
- (instancetype)initWithReachability:(AFNetworkReachabilityManager *)reachability;

- (BOOL)isReachable;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;

- (CCNetworkType)networkType;
- (CCNetworkWWANType)networkWWANType;
@end
