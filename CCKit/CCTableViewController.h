//
//  CCTableViewController.h
//  CCKit
//
//  Created by can on 17/1/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCViewController.h"
#import "CCTableViewDataSource.h"

@interface CCTableViewController : CCViewController <UITableViewDelegate, UITableViewDataSource>
{
    __strong UITableView *_tableView;
    __strong id<CCTableViewDataSource> _dataSource;
}
@property (nonatomic, strong) UITableView *tableView;
// NOT ALLOWED: dataSource = self
@property (nonatomic, strong) id<CCTableViewDataSource> dataSource;
@end
