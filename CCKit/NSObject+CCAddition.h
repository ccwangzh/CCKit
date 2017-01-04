//
//  NSObject+CCAddition.h
//  CCKit
//
//  Created by can on 17/1/4.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CCAddition)
- (void)setAssociatedObject:(id)object key:(const void *)key;
- (id)getAssociatedObjectForKey:(const void *)key;
@end
