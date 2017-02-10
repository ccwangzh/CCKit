//
//  CCKeychain.h
//  CCKit
//
//  Created by can on 17/2/10.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCKeychain : NSObject
+ (instancetype)keychain;
@end

@interface CCSecItem : NSObject

@end

@interface CCSecPasswordItem : CCSecItem
@property (nonatomic, strong) NSString *account;
@end

@interface CCSecGenericPasswordItem : CCSecPasswordItem
@property (nonatomic, strong) NSString *service;
- (OSStatus)secDelete;
- (OSStatus)secAddObject:(id)object;
- (OSStatus)secGetOneObject:(id *)objectRef;
@end
