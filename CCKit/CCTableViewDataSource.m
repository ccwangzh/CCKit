//
//  CCTableViewDataSource.m
//  CCKit
//
//  Created by can on 17/1/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewDataSource.h"

@interface CCTableViewDataSource ()

@end

@implementation CCTableViewDataSource
- (instancetype)init {
    if (self = [super init]) {
        _sections = [NSMutableArray new];
    }
    return self;
}

- (NSMutableArray *)sections {
    return _sections;
}

- (NSUInteger)count {
    return [[self sections] count];
}

- (id)objectAtIndex:(NSUInteger)index {
    NSMutableArray *sections = [self sections];
    if (index < sections.count) {
        return [sections objectAtIndex:index];
    }
    return nil;
}

- (void)addObject:(id)anObject {
    [self.sections addObject:anObject];
}

- (void)removeAllObjects {
    [self.sections removeAllObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CCTableViewSection> section = [self.sections objectAtIndex:indexPath.section];
    id<CCTableViewCellModel> cellModel = [section objectAtIndex:indexPath.row];
    
    NSString *identifier = cellModel.cellId; Class cellClass = [cellModel cellClass];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([cell conformsToProtocol:@protocol(CCTableViewCell)]) {
        id<CCTableViewCell> ccCell = (id<CCTableViewCell>)cell;
        [ccCell setDelegate:tableView.delegate];
        [ccCell setModel:cellModel];
    } else {
        if ([cell respondsToSelector:@selector(setDelegate:)]) {
            [cell setValue:tableView.delegate forKey:@"delegate"];
        }
        if ([cell respondsToSelector:@selector(setModel:)]) {
            [cell setValue:cellModel forKey:@"model"];
        }
    }
    return cell;
}

@end

@implementation CCTableViewSection

- (instancetype)init {
    if (self = [super init]) {
        _cells = [NSMutableArray new];
    }
    return self;
}

- (NSMutableArray *)cells {
    return _cells;
}

- (NSUInteger)count {
    return [[self cells] count];
}

- (id)objectAtIndex:(NSUInteger)index {
    NSMutableArray *cells = [self cells];
    if (index < cells.count) {
        return [cells objectAtIndex:index];
    }
    return nil;
}

- (void)addObject:(id)anObject {
    [self.cells addObject:anObject];
}

- (void)removeAllObjects {
    [self.cells removeAllObjects];
}
@end

@implementation CCTableViewCellModel

- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
}

- (Class)cellClass {
    return _cellClass;
}

- (void)setCellId:(NSString *)cellId {
    _cellId = cellId;
}

- (NSString *)cellId {
    return _cellId;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
}

- (CGFloat)cellHeight {
    return _cellHeight;
}

@end

@implementation CCTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {

}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
}

- (id)delegate {
    return _delegate;
}

- (void)setModel:(id<CCTableViewCellModel>)model {
    _model = model;
}

- (id<CCTableViewCellModel>)model {
    return _model;
}

@end
