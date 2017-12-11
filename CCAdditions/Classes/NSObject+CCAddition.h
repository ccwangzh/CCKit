//
//  NSObject+CCAddition.h
//  CCAdditions
//
//  Created by ccwangzh on 2017/12/11.
//

#import <Foundation/Foundation.h>

@interface NSObject (CCAddition)
- (id)getAssociatedObjectForKey:(const void *)key;
- (void)setAssociatedObject:(id)object key:(const void *)key;
@end
