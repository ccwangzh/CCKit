//
//  CMMoney+WCTTableCoding.m
//  CCKitMoney
//
//  Created by can on 2017/11/30.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CMMoney+WCTTableCoding.h"

@implementation CMMoney (WCTTableCoding)
WCDB_IMPLEMENTATION(CMMoney)
WCDB_SYNTHESIZE(CMMoney, sn)
WCDB_SYNTHESIZE(CMMoney, type)
WCDB_SYNTHESIZE(CMMoney, amount)
WCDB_SYNTHESIZE(CMMoney, userSn)
WCDB_SYNTHESIZE(CMMoney, categorySn)
WCDB_SYNTHESIZE(CMMoney, orderedTime)
WCDB_SYNTHESIZE(CMMoney, createdTime)
WCDB_SYNTHESIZE(CMMoney, updatedTime)
@end
