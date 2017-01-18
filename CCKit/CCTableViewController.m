//
//  CCTableViewController.m
//  CCKit
//
//  Created by can on 17/1/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewController.h"

@interface CCTableViewController ()

@end

@implementation CCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = self.tableView;
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = _dataSource;
        self.tableView = tableView;
        [self.view addSubview:tableView];
    }
}

- (void)setDataSource:(id<CCTableViewDataSource>)dataSource {
    assert(dataSource != (id)self);
    
    _dataSource = dataSource;
    UITableView *tableView = self.tableView;
    if (tableView) {
        tableView.dataSource = dataSource;
    }
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    if (_dataSource) {
        tableView.dataSource = _dataSource;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSource == nil) return 44.0f;
    id<CCTableViewSection> section = [self.dataSource objectAtIndex:indexPath.section];
    return [[section objectAtIndex:indexPath.row] cellHeight];
}

@end
