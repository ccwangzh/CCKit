//
//  RCTSample.m
//  CCKit
//
//  Created by can on 17/9/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "RCTSample.h"

@implementation RCTSample
RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

@end
