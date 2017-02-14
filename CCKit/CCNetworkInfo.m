//
//  CCNetworkInfo.m
//  CCKit
//
//  Created by can on 17/2/14.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCNetworkInfo.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface CCNetworkInfo ()
{
    AFNetworkReachabilityManager *_reachability;
    CTTelephonyNetworkInfo *_networkInfo;
}
@end

@implementation CCNetworkInfo
+ (instancetype)networkInfo {
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager manager];
    return [[self alloc] initWithReachability:reachability];
}

- (instancetype)initWithReachability:(AFNetworkReachabilityManager *)reachability {
    if (self = [super init]) {
        _reachability = reachability;
        [reachability startMonitoring];
    }
    return self;
}

- (BOOL)isReachable {
    AFNetworkReachabilityManager *reachability = _reachability;
    return [reachability isReachableViaWWAN] || [reachability isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    AFNetworkReachabilityManager *reachability = _reachability;
    return reachability.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    AFNetworkReachabilityManager *reachability = _reachability;
    return reachability.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

- (CCNetworkType)networkType {
    AFNetworkReachabilityManager *reachability = _reachability;
    return (NSInteger)reachability.networkReachabilityStatus;
}

- (CCNetworkWWANType)networkWWANType {
    CTTelephonyNetworkInfo *networkInfo = _networkInfo;
    if (networkInfo == nil) return CCNetworkWWANTypeUnkown;
    
    NSString *status = networkInfo.currentRadioAccessTechnology;
    if (status == nil) return CCNetworkWWANTypeUnkown;

    NSDictionary *info = [self radioAccessTechnologyInfo];
    NSNumber *technology = info[status];
    if (technology == nil) return CCNetworkWWANTypeUnkown;
    
    return technology.unsignedIntegerValue;
}

- (CTTelephonyNetworkInfo *)networkInfo {
    if (_networkInfo) {
        return _networkInfo;
    }
    _networkInfo = [CTTelephonyNetworkInfo new];
    return _networkInfo;
}

- (NSDictionary *)radioAccessTechnologyInfo {
    static NSDictionary *_info;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _info = @{CTRadioAccessTechnologyGPRS : @(CCNetworkWWANType2G),  // 2.5G   171Kbps
                  CTRadioAccessTechnologyEdge : @(CCNetworkWWANType2G),  // 2.75G  384Kbps
                  CTRadioAccessTechnologyWCDMA : @(CCNetworkWWANType3G), // 3G     3.6Mbps/384Kbps
                  CTRadioAccessTechnologyHSDPA : @(CCNetworkWWANType3G), // 3.5G   14.4Mbps/384Kbps
                  CTRadioAccessTechnologyHSUPA : @(CCNetworkWWANType3G), // 3.75G  14.4Mbps/5.76Mbps
                  CTRadioAccessTechnologyCDMA1x : @(CCNetworkWWANType3G), // 2.5G
                  CTRadioAccessTechnologyCDMAEVDORev0 : @(CCNetworkWWANType3G),
                  CTRadioAccessTechnologyCDMAEVDORevA : @(CCNetworkWWANType3G),
                  CTRadioAccessTechnologyCDMAEVDORevB : @(CCNetworkWWANType3G),
                  CTRadioAccessTechnologyeHRPD : @(CCNetworkWWANType3G),
                  CTRadioAccessTechnologyLTE : @(CCNetworkWWANType4G)}; // LTE:3.9G 150M/75M  LTE-Advanced:4G 300M/150M
    });
    return _info;
}

@end
