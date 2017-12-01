//
//  CMDbHelper.h
//  CCKitMoney
//
//  Created by can on 2017/12/1.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMDbHelper : NSObject
+ (instancetype)helper;

- (BOOL)insertObject:(id)object;

- (id)getOneObjectOfClass:(Class)cls;

@end
