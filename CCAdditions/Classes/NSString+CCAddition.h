//
//  NSString+CCAddition.h
//  CCAdditions
//
//  Created by ccwangzh on 2017/12/11.
//

#import <Foundation/Foundation.h>

@interface NSString (CCAddition)
@property (readonly) NSString *md5Value;
@property (readonly) NSString *sha1Value;
@property (readonly) NSString *sha256Value;
@end
