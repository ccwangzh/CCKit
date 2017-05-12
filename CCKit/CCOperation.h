//
//  CCOperation.h
//  CCKit
//
//  Created by can on 17/5/12.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCOperation : NSOperation
{
    BOOL _cancelled;
    BOOL _executing;
    BOOL _finished;
}
- (void)setCancelled:(BOOL)isCancelled;
- (void)setExecuting:(BOOL)isExecuting;
- (void)setFinished:(BOOL)isFinished;
@end
