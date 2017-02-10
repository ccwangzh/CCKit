//
//  CCTableViewTestCellModel.m
//  CCKit
//
//  Created by can on 17/2/9.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestCellModel.h"

@implementation CCTableViewTestCellModel

- (NSString *)cellId {
    return @"CCTableViewTestCell";
}

- (CGFloat)cellHeight {
    return 44.0f;
}

- (Class)cellClass {
    return [CCTableViewTestCell class];
}

- (void)setUp {}
- (void)tearDown {}
- (void)doTest {}

@end

@implementation CCTableViewTestCell
@dynamic model;
- (void)setup {
    [super setup];
}
- (void)setModel:(CCTableViewTestCellModel *)model {
    _model = model;
    self.textLabel.text = model.title;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
