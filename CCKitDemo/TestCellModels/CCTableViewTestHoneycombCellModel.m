//
//  CCTableViewTestHoneycombCellModel.m
//  CCKit
//
//  Created by can on 17/8/10.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestHoneycombCellModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "UIImage+CCAddition.h"

@interface CCTableViewTestHoneycombViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    __strong UITableView *_tableView;
    __strong NSMutableArray *_tableList;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;
@end

@interface CCTableViewImageCellModel : NSObject
@property (nonatomic) NSURL *imageURL;
@end

@interface CCTableViewImageCell : UITableViewCell
@property (nonatomic) CCTableViewImageCellModel *model;
@end

@implementation CCTableViewTestHoneycombCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Honeycomb";
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
    UIApplication *application = [UIApplication sharedApplication];
    UIViewController *rootController = [application keyWindow].rootViewController;
    UITabBarController *tabController = (UITabBarController *)rootController;
    UINavigationController *navController = [tabController selectedViewController];
    
    CCTableViewTestHoneycombViewController *testController = nil;
    testController = [CCTableViewTestHoneycombViewController new];
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}

@end

@implementation CCTableViewTestHoneycombViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = self.tableView;
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
        [self.view addSubview:tableView];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableArray *tableList = [NSMutableArray new];
    NSMutableArray *section = [NSMutableArray new];
    [tableList addObject:section];
    
    CCTableViewImageCellModel *model1 = [CCTableViewImageCellModel new];
    NSString *uri = @"https://img.vipstatic.com/vfc/image/2017/08/02/175/b8a03c704a0c47eba593041183cd62bb.jpg";
    model1.imageURL = [NSURL URLWithString:uri];
    [section addObject:model1];
    
    self.tableList = tableList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tableList objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self.tableList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *section = [self.tableList objectAtIndex:indexPath.section];
    id<CCTableViewCellModel> cellModel = [section objectAtIndex:indexPath.row];
    
    NSString *identifier = cellModel.cellId; Class cellClass = [cellModel cellClass];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell setValue:tableView.delegate forKey:@"delegate"];
    }
    if ([cell respondsToSelector:@selector(setModel:)]) {
        [cell setValue:cellModel forKey:@"model"];
    }
    return cell;
}

@end

@implementation CCTableViewImageCellModel
- (NSString *)cellId {
    return @"CCTableViewImageCell";
}

- (CGFloat)cellHeight {
    return 200.0 / 690.0 * [UIScreen mainScreen].bounds.size.width;
}

- (Class)cellClass {
    return [CCTableViewImageCell class];
}
@end

@interface CCTableViewImageCell ()
@property (nonatomic) UIImageView *picView;
@end

@implementation CCTableViewImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
        if (!_picView) {
            UIImageView *picView = [UIImageView new];
            picView.frame = self.contentView.bounds;
            picView.layer.masksToBounds = YES;
            picView.layer.borderWidth = 1.0f;
            picView.layer.borderColor = [UIColor blackColor].CGColor;
            picView.contentMode = UIViewContentModeScaleAspectFit;
            picView.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
            picView.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
            [self.contentView addSubview:picView];
            _picView = picView;
        }
    }
    return self;
}

- (void)setModel:(CCTableViewImageCellModel *)model {
    _model = model;
    [self.picView setImageWithURL:model.imageURL placeholderImage:nil];
}
@end
