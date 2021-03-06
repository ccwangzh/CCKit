//
//  ViewController.m
//  CCKitDemo
//
//  Created by can on 17/1/3.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "ViewController.h"

#import "CCTableViewTestCacheCellModel.h"
#import "CCTableViewTestAdditionCellModel.h"
#import "CCTableViewTestKeychainCellModel.h"
#import "CCTableViewTestNetworkingCellModel.h"
#import "CCTableViewTestWebviewCellModel.h"
#import "CCTableViewTestCordovaCellModel.h"
#import "CCTableViewTestOperationCellModel.h"
#import "CCTableViewTestServicesCellModel.h"
#import "CCTableViewTestCollectionsCellModel.h"
#import "CCTableViewTestExamplesCellModel.h"
#import "CCTableViewTestHoneycombCellModel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CCTableViewDataSource *dataSource = [CCTableViewDataSource new];
    self.dataSource = dataSource;
    
    CCTableViewSection *section = [CCTableViewSection new];
    [dataSource addObject:section];
    
    [section addObject:[CCTableViewTestCacheCellModel new]];

    [section addObject:[CCTableViewTestAdditionCellModel new]];
    
    [section addObject:[CCTableViewTestKeychainCellModel new]];
    
    [section addObject:[CCTableViewTestNetworkingCellModel new]];
    
    [section addObject:[CCTableViewTestWebviewCellModel new]];
    
    [section addObject:[CCTableViewTestCordovaCellModel new]];
    
    [section addObject:[CCTableViewTestOperationCellModel new]];
    
    [section addObject:[CCTableViewTestServicesCellModel new]];
    
    [section addObject:[CCTableViewTestCollectionsCellModel new]];
    
    [section addObject:[CCTableViewTestExamplesCellModel new]];
    
    [section addObject:[CCTableViewTestHoneycombCellModel new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[[self dataSource] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] doTest];
}

@end

