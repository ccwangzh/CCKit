//
//  CMMoney+WCTTableCoding.h
//  CCKitMoney
//
//  Created by can on 2017/11/30.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CMMoney.h"
#import <WCDB/WCDB.h>

@interface CMMoney (WCTTableCoding) <WCTTableCoding>
WCDB_PROPERTY(sn)
WCDB_PROPERTY(type)
WCDB_PROPERTY(amount)
WCDB_PROPERTY(userSn)
WCDB_PROPERTY(categorySn)
WCDB_PROPERTY(orderedTime)
WCDB_PROPERTY(createdTime)
WCDB_PROPERTY(updatedTime)
@end
