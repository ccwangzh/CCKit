//
//  CMMoney.h
//  CCKitMoney
//
//  Created by can on 2017/11/30.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMoney : NSObject
/*
 序列号
 */
@property (nonatomic, strong) NSString *sn;
/*
 类型
 */
@property (nonatomic, assign) long type;
/*
 金额
 */
@property (nonatomic, assign) float amount;
/*
 用户序列号
 */
@property (nonatomic) NSString *userSn;
/*
 分类序列号
 */
@property (nonatomic) NSString *categorySn;
/*
 产生时间
 */
@property (nonatomic, assign) long orderedTime;
/*
 创建时间
 */
@property (nonatomic, assign) long createdTime;
/*
 更新时间
 */
@property (nonatomic, assign) long updatedTime;
@end
