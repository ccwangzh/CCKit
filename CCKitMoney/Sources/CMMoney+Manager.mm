//
//  CMMoney+Manager.m
//  CCKitMoney
//
//  Created by can on 2017/11/30.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CMMoney+Manager.h"
#import "CMDbHelper.h"
@implementation CMMoney (Manager)
- (BOOL)save {
    return [[CMDbHelper helper] insertObject:self];
}

+ (id)get {
    return [[CMDbHelper helper] getOneObjectOfClass:self];
}

@end
