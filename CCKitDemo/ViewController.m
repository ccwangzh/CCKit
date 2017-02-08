//
//  ViewController.m
//  CCKitDemo
//
//  Created by can on 17/1/3.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "ViewController.h"

#import "CCNetworking.h"

@class CCTableViewTestCell;

typedef void(^CCTableViewTestCellSelectHandler)(CCTableViewTestCell *cell);

@interface CCTableViewTestCellModel : CCTableViewCellModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) CCTableViewTestCellSelectHandler selectHandler;
@end

@interface CCTableViewTestCell : CCTableViewCell
@property (nonatomic, strong) CCTableViewTestCellModel *model;
@end

@interface CCTableViewTestCell ()

@end

@interface ViewController ()

@end

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
    if (model.selectHandler) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end

@interface CCTestRequest : CCHttpRequest

@end

@implementation CCTestRequest
- (NSString *)requestUrl {
    return @"http://jr-api.vip.com/common/now_time/v1";
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CCTableViewDataSource *dataSource = [CCTableViewDataSource new];
    self.dataSource = dataSource;
    
    CCTableViewSection *section = [CCTableViewSection new];
    [dataSource addObject:section];
    
    CCTableViewTestCellModel *cell = nil;
    
    cell = [CCTableViewTestCellModel new];
    cell.title = @"测试：网络";
    cell.selectHandler = ^(CCTableViewTestCell *cell) {
        CCTestRequest *request = [CCTestRequest new];
        [[CCApiClient apiClient] sendRequest:request completionHandler:^(CCHttpResponse *response, NSError *error) {
            
        }];
    };
    [section addObject:cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CCTableViewTestCellModel *model = [[[self dataSource] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (model && model.selectHandler) {
        CCTableViewTestCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        model.selectHandler(cell);
    }
}

@end

