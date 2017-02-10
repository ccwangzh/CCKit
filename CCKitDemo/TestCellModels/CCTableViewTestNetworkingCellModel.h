//
//  CCTableViewTestNetworkingCellModel.h
//  CCKit
//
//  Created by can on 17/2/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCellModel.h"

#import "CCNetworking.h"

@interface CCTableViewTestNetworkingCellModel : CCTableViewTestCellModel

@end

@interface CCVIPApiRequest : CCApiRequest
@property (nonatomic, strong) NSString *reqTime;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *app_version;
@end

@interface CCVIPApiResponse : CCApiResponse
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, strong) id results;
@end

@interface CCHttpResponse (CCVIPApiResponse)
- (BOOL)success;
- (NSString *)message;
- (NSInteger)resultCode;
- (id)results;
@end

@interface CCTimeRequest : CCVIPApiRequest
@property (nonatomic, strong) NSString *t;
@end

@class CCTimeResult;
@interface CCTimeResponse : CCVIPApiResponse
@property (nonatomic, strong) CCTimeResult *results;
@end

@interface CCTimeResult : NSObject
@property (nonatomic, assign) long timestamp;
@end

NSString *VFApiSign(NSDictionary *, NSString *, NSString *);
