//
//  CCTableViewTestCellModel.h
//  CCKit
//
//  Created by can on 17/2/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCTableViewController.h"

@interface CCTableViewTestCellModel : CCTableViewCellModel
@property (nonatomic, strong) NSString *title;
- (void)setUp;
- (void)tearDown;
- (void)doTest;
@end

@interface CCTableViewTestCell : CCTableViewCell
@property (nonatomic, strong) CCTableViewTestCellModel *model;
@end

@interface CCTableViewTestCell ()

@end
