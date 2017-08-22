//
//  CCTableViewTestHoneycombCellModel.m
//  CCKit
//
//  Created by can on 17/8/10.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestHoneycombCellModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "UIColor+CCAddition.h"
#import "UIImage+CCAddition.h"

@interface UIImageView (Honeycomb)
+ (instancetype)corneredImageView;
@end
@implementation UIImageView (Honeycomb)
+ (instancetype)corneredImageView {
    return nil;
}
@end

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

@interface CCTableViewColorCellModel : NSObject

@end

@interface CCTableViewColorCell : UITableViewCell
@property (nonatomic) CCTableViewColorCellModel *model;
@end

@interface CCTableViewModuleCellModel : NSObject
@property (nonatomic, strong) NSDictionary *module;
- (instancetype)initWithModule:(NSDictionary *)module;
@end

@interface CCTableViewModuleCell : UITableViewCell
@property (nonatomic) CCTableViewModuleCellModel *model;
- (void)setup;
@end

@interface CCTableViewModule0Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule1Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule2Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule3Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule4Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule5Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule6Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule7Cell : CCTableViewModuleCell

@end

@interface CCTableViewModule8Cell : CCTableViewModuleCell

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
    
    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule0Cell",
          @"cellHeight": @(40),
          @"cellClass": [CCTableViewModule0Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }

    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule1Cell",
          @"cellHeight": @(88),
          @"cellClass": [CCTableViewModule1Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }

    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule2Cell",
          @"cellHeight": @(110),
          @"cellClass": [CCTableViewModule2Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }

    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule3Cell",
          @"cellHeight": @([UIScreen mainScreen].bounds.size.width * 140 / 375 + 8 + 44 + 15),
          @"cellClass": [CCTableViewModule3Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }

    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule4Cell",
          @"cellHeight": @([UIScreen mainScreen].bounds.size.width * 190 / 375 + 8 + 44 + 15),
          @"cellClass": [CCTableViewModule4Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }
    
    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule5Cell",
          @"cellHeight": @([UIScreen mainScreen].bounds.size.width * 81 * 2 / 375 + 8 + 7 + 44 + 15),
          @"cellClass": [CCTableViewModule5Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }

    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule6Cell",
          @"cellHeight": @([UIScreen mainScreen].bounds.size.width * 81 * 2 / 375 + 8 + 44 + 15),
          @"cellClass": [CCTableViewModule6Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }
    
    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule7Cell",
          @"cellHeight": @([UIScreen mainScreen].bounds.size.width * (165 + 122) / 375 + 8 + 44 + 17.5 + 82 + 44),
          @"cellClass": [CCTableViewModule7Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section addObject:model];
    }

    {
        CCTableViewModuleCellModel *model = nil;
        NSDictionary *module =
        @{
          @"cellId": @"CCTableViewModule8Cell",
          @"cellHeight": @([UIScreen mainScreen].bounds.size.width * (150) / 375),
          @"cellClass": [CCTableViewModule8Cell class],
          };
        model = [[CCTableViewModuleCellModel alloc] initWithModule:module];
        [section insertObject:model atIndex:0];
    }
    
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
        self.backgroundColor = [UIColor randomColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

@implementation CCTableViewColorCellModel
- (NSString *)cellId {
    return @"CCTableViewColorCell";
}

- (CGFloat)cellHeight {
    return 200.0 / 690.0 * [UIScreen mainScreen].bounds.size.width;
}

- (Class)cellClass {
    return [CCTableViewColorCell class];
}
@end

@interface CCTableViewColorCell ()
@property (nonatomic) UIImageView *picView;
@end

@implementation CCTableViewColorCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor randomColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(CCTableViewColorCellModel *)model {
    _model = model;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
@end

@implementation CCTableViewModuleCellModel
- (instancetype)initWithModule:(NSDictionary *)module {
    if (self = [super init]) {
        _module = module;
    }
    return self;
}
- (NSString *)cellId {
    return _module[@"cellId"];
}

- (CGFloat)cellHeight {
    return [_module[@"cellHeight"] floatValue];
}

- (Class)cellClass {
    return _module[@"cellClass"];
}
@end

@interface CCTableViewModuleCell ()

@end

@implementation CCTableViewModuleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(CCTableViewModuleCellModel *)model {
    _model = model;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
@end

@interface CCTableViewModule0Cell ()
@property (nonatomic) NSMutableArray *labels;
@property (nonatomic) NSMutableArray *badges;
@end

@implementation CCTableViewModule0Cell
- (void)setup {
    [super setup];
    if (!_labels) {
        _labels = [NSMutableArray new];
    }
    [_labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_labels removeAllObjects];
    if (!_badges) {
        _badges = [NSMutableArray new];
    }
    [_badges makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_badges removeAllObjects];

    UILabel *label; UIImageView *badge;
    for (NSInteger i = 0; i < 3; i ++) {
        label = [[UILabel alloc] init];
        label.text = @"哈哈哈哈哈";
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorWithRGB:0x98989f];
        //label.backgroundColor = [UIColor blueColor];
        [_labels addObject:label];
        [self.contentView addSubview:label];
        
        badge = [[UIImageView alloc] init];
        [_badges addObject:badge];
        badge.layer.borderWidth = 1.0f;
        badge.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:badge];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(CCTableViewModuleCellModel *)model {
    [super setModel:model];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0; CGFloat y = 0;
    CGFloat icon_tail = 3;
    CGSize boundsSize = self.bounds.size;
    NSInteger count = _labels.count;
    UILabel *label; UIImageView *badge;
    
    for (NSInteger i = 0; i < count; i ++) {
        badge = [_badges objectAtIndex:i];
        CGFloat y2 = y + (boundsSize.height - 12) / 2;
        badge.frame = CGRectMake(x, y2, 12, 12);
        
        label = [_labels objectAtIndex:i];
        CGRect rect = CGRectMake(0, 0, boundsSize.width, boundsSize.height);
        rect = [label textRectForBounds:rect limitedToNumberOfLines:1];
        y2 = y + (boundsSize.height - rect.size.height) / 2;
        CGFloat x2 = badge.frame.origin.x + badge.frame.size.width + icon_tail;
        label.frame = CGRectMake(x2, y2, rect.size.width, rect.size.height);
        x = label.frame.origin.x + label.frame.size.width;
    }
    
    if (count > 1) {
        CGFloat margin = 30.0f;
        CGFloat width = boundsSize.width - margin * 2;
        CGFloat space = (width - x) / (count - 1);
        CGFloat start_x = margin;
        for (NSInteger i = 0; i < count; i ++) {
            badge = [_badges objectAtIndex:i];
            CGRect frame = badge.frame;
            frame.origin.x = start_x;
            badge.frame = frame;
            start_x += frame.size.width + icon_tail;
            label = [_labels objectAtIndex:i];
            frame = label.frame;
            frame.origin.x = start_x;
            label.frame = frame;
            start_x += frame.size.width + space;
        }
    }
}
@end

@interface CCTableViewModule1Cell ()
@property (nonatomic) NSMutableArray *labels;
@property (nonatomic) NSMutableArray *badges;
@end

@implementation CCTableViewModule1Cell
- (void)setup {
    [super setup];
    if (!_labels) {
        _labels = [NSMutableArray new];
    }
    [_labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_labels removeAllObjects];
    if (!_badges) {
        _badges = [NSMutableArray new];
    }
    [_badges makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_badges removeAllObjects];
    
    UILabel *label; UIImageView *badge;
    for (NSInteger i = 0; i < 10; i ++) {
        label = [[UILabel alloc] init];
        label.text = @"哈哈";
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRGB:0x585c64];
        //label.backgroundColor = [UIColor blueColor];
        [_labels addObject:label];
        [self.contentView addSubview:label];
        
        badge = [[UIImageView alloc] init];
        [_badges addObject:badge];
        badge.layer.borderWidth = 1.0f;
        badge.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:badge];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGSize boundsSize = self.bounds.size;
    CGFloat lineWidth = 1.0 / [UIScreen mainScreen].scale;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, lineWidth);
    CGFloat heigth = boundsSize.height / 2.0f;
    CGFloat width = boundsSize.width / 5.0f;
    for (NSInteger i = 0; i < 10; i ++) {
        CGFloat x = width * (i % 5);
        CGFloat y = heigth * (i / 5);
        CGContextMoveToPoint(context, x, y + 0.5);
        CGContextAddLineToPoint(context, x + width + 1, y + 0.5);
        CGContextAddLineToPoint(context, x + width + 1, y + heigth);
        CGContextStrokePath(context);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize boundsSize = self.bounds.size;
    CGFloat heigth = boundsSize.height / 2.0f;
    CGFloat width = boundsSize.width / 5.0f;
    UILabel *label; UIImageView *badge;
    for (NSInteger i = 0; i < 10; i ++) {
        CGFloat x = width * (i % 5);
        CGFloat y = heigth * (i / 5);
        
        label = [_labels objectAtIndex:i];
        CGRect rect = CGRectMake(0, 0, width, heigth);
        rect = [label textRectForBounds:rect limitedToNumberOfLines:1];
        CGFloat y2 = y + (heigth - rect.size.height) / 2;
        label.frame = CGRectMake(x, y2, width, rect.size.height);
        
        badge = [_badges objectAtIndex:i];
        CGFloat x2 = x + width / 2 + rect.size.width / 2;
        badge.frame = CGRectMake(x2, y, 20, 16);
    }
}

@end

@interface CCTableViewModule2Cell ()
@property (nonatomic) NSMutableArray *labels;
@property (nonatomic) NSMutableArray *badges;
@end

@implementation CCTableViewModule2Cell
- (void)setup {
    [super setup];
    if (!_labels) {
        _labels = [NSMutableArray new];
    }
    [_labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_labels removeAllObjects];
    if (!_badges) {
        _badges = [NSMutableArray new];
    }
    [_badges makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_badges removeAllObjects];
    
    UILabel *label; UIImageView *badge;
    for (NSInteger i = 0; i < 10; i ++) {
        label = [[UILabel alloc] init];
        label.text = @"哈哈";
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRGB:0x585c64];
        //label.backgroundColor = [UIColor blueColor];
        [_labels addObject:label];
        [self.contentView addSubview:label];
        
        badge = [[UIImageView alloc] init];
        [_badges addObject:badge];
        badge.layer.borderWidth = 1.0f;
        badge.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:badge];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize boundsSize = self.bounds.size;
    CGFloat heigth = boundsSize.height / 2.0f;
    CGFloat width = boundsSize.width / 5.0f;
    UILabel *label; UIImageView *badge;
    for (NSInteger i = 0; i < 10; i ++) {
        CGFloat x = width * (i % 5);
        CGFloat y = heigth * (i / 5);
        
        badge = [_badges objectAtIndex:i];
        CGFloat x2 = x + (width - 60) / 2;
        badge.frame = CGRectMake(x2, y, 60, 26);
        
        label = [_labels objectAtIndex:i];
        CGRect rect = CGRectMake(0, 0, width, heigth);
        rect = [label textRectForBounds:rect limitedToNumberOfLines:1];
        CGFloat y2 = y + badge.frame.size.height + 5;
        label.frame = CGRectMake(x, y2, width, rect.size.height);
    }
}
@end

@interface CCTableViewModule3Cell ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) NSMutableArray *images;
@end

@implementation CCTableViewModule3Cell
- (void)setup {
    [super setup];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"模块标题";
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_titleLabel];
    }

    if (!_images) {
        _images = [NSMutableArray new];
    }
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_images removeAllObjects];
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < 3; i ++) {
        image = [[UIImageView alloc] init];
        [_images addObject:image];
        image.layer.borderWidth = 1.0f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:image];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRGB:0xf3f4f5] set];
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 8));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 15, 200, 28);
    
    NSInteger count = arc4random() % 2 + 2;
    
    CGFloat margin = 15.0f;
    CGFloat start_x = margin;
    CGFloat start_y = 44.0f + 8.0f;
    CGSize boundsSize = self.bounds.size;
    CGFloat image_height = 140.0f;
    CGFloat image_witdh = count == 3 ? 110 : 169;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = image_witdh * screenWidth / 375;
    CGFloat height = width * image_height / image_witdh;
    CGFloat space = (boundsSize.width - margin * 2 - width * count) / (count - 1);
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < 3; i ++) {
        image = [_images objectAtIndex:i];
        CGFloat x = start_x + (width + space) * i;
        image.frame = CGRectMake(x, start_y, width, height);
        image.hidden = i >= count;
    }
}
@end

@interface CCTableViewModule4Cell ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) NSMutableArray *images;
@end

@implementation CCTableViewModule4Cell
- (void)setup {
    [super setup];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"模块标题";
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_titleLabel];
    }
    
    if (!_images) {
        _images = [NSMutableArray new];
    }
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_images removeAllObjects];
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < 3; i ++) {
        image = [[UIImageView alloc] init];
        [_images addObject:image];
        image.layer.borderWidth = 1.0f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:image];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRGB:0xf3f4f5] set];
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 8));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 15, 200, 28);
    
    UIImageView *image = nil;
    CGFloat margin = 15.0f;
    CGFloat start_x = margin;
    CGFloat start_y = 44.0f + 8.0f;
    CGFloat image_height = 190.0f;
    CGSize boundsSize = self.bounds.size;
    
    NSInteger count = 3;
    
    if (count == 1) {
        CGFloat image_witdh = 345.0f;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat width = image_witdh * screenWidth / 375;
        CGFloat height = width * image_height / image_witdh;
        for (NSInteger i = 0; i < 3; i ++) {
            image = [_images objectAtIndex:i];
            image.frame = CGRectMake(start_x, start_y, width, height);
            image.hidden = i >= count;
        }
    } else if (count == 2) {
        CGFloat image_witdh = 169.0f;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat width = image_witdh * screenWidth / 375;
        CGFloat height = width * image_height / image_witdh;
        CGFloat space = (boundsSize.width - margin * 2 - width * count) / (count - 1);
        for (NSInteger i = 0; i < 3; i ++) {
            image = [_images objectAtIndex:i];
            CGFloat x = start_x + (width + space) * i;
            image.frame = CGRectMake(x, start_y, width, height);
            image.hidden = i >= count;
        }
    } else if (count == 3) {
        CGFloat image_witdh = 169.0f;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat width = image_witdh * screenWidth / 375;
        CGFloat height = width * image_height / image_witdh;
        CGFloat space = (boundsSize.width - margin * 2 - width * 2) / 2;
        
        for (NSInteger i = 0; i < 1; i ++) {
            image = [_images objectAtIndex:i];
            CGFloat x = start_x + (width + space) * i;
            image.frame = CGRectMake(x, start_y, width, height);
            image.hidden = i >= count;
        }
        
        CGFloat image_height = 91.5f;
        CGFloat height2 = width * image_height / image_witdh;
        CGFloat space2 = height - 2 * height2;
        CGFloat x = start_x + (width + space) * 1;
        for (NSInteger i = 1; i < 3; i ++) {
            image = [_images objectAtIndex:i];
            CGFloat y = start_y + (height2 + space2) * (i - 1);
            image.frame = CGRectMake(x, y, width, height2);
            image.hidden = i >= count;
        }
    }
}
@end


@interface CCTableViewModule5Cell ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) NSMutableArray *images;
@end

@implementation CCTableViewModule5Cell
- (void)setup {
    [super setup];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"模块标题";
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_titleLabel];
    }
    
    if (!_images) {
        _images = [NSMutableArray new];
    }
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_images removeAllObjects];
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < 8; i ++) {
        image = [[UIImageView alloc] init];
        [_images addObject:image];
        image.layer.borderWidth = 1.0f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:image];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRGB:0xf3f4f5] set];
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 8));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 15, 200, 28);

    CGFloat margin = 15.0f;
    CGFloat start_x = margin;
    CGFloat start_y = 44.0f + 8.0f;
    CGFloat image_witdh = 81.0f;
    CGFloat image_height = 81.0f;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = image_witdh * screenWidth / 375;
    CGFloat height = width * image_height / image_witdh;
    CGFloat space = (screenWidth - 30 - 4 * width) / 4;
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < 8; i ++) {
        image = [_images objectAtIndex:i];
        CGFloat x = start_x + (width + space) * (i % 4);
        CGFloat y = start_y + (height + 7) * (i / 4);
        image.frame = CGRectMake(x, y, width, height);
    }
}
@end

@interface CCTableViewModule6Cell ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *extendLabel;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray *images;
@end

@implementation CCTableViewModule6Cell
- (void)setup {
    [super setup];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"模块标题";
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_titleLabel];
    }
    
    if (!_extendLabel) {
        _extendLabel = [[UILabel alloc] init];
        _extendLabel.text = @"模块标题";
        _extendLabel.font = [UIFont systemFontOfSize:14.0f];
        _extendLabel.textAlignment = NSTextAlignmentCenter;
        _extendLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_extendLabel];
    }
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:_scrollView];
    }
    
    if (!_images) {
        _images = [NSMutableArray new];
    }
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_images removeAllObjects];
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < 8; i ++) {
        image = [[UIImageView alloc] init];
        [_images addObject:image];
        image.layer.borderWidth = 1.0f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        [_scrollView addSubview:image];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRGB:0xf3f4f5] set];
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 8));
    
    [[UIColor colorWithRGB:0xf0f0f0] set];
    CGContextMoveToPoint(context, 0, rect.size.height - 44);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 44);
    CGContextStrokePath(context);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 15, 200, 28);
    
    CGFloat margin = 15.0f;
    CGFloat image_witdh = 100.0f;
    CGFloat image_height = 120.0f;
    CGSize boundsSize = self.bounds.size;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = image_witdh * screenWidth / 375;
    CGFloat height = width * image_height / image_witdh;
    _scrollView.frame = CGRectMake(0, 44 + 8, boundsSize.width, height);
    
    UIImageView *image = nil;
    for (NSInteger i = 0; i < _images.count; i ++) {
        image = [_images objectAtIndex:i];
        CGFloat x = margin + (width + 7) * i;
        image.frame = CGRectMake(x, 0, width, height);
    }
    
    _scrollView.contentSize = CGSizeMake(margin * 2 + _images.count * (width + 7) - 7, height);
    
    _extendLabel.frame = CGRectMake(0, boundsSize.height - 44, boundsSize.width, 44);
}
@end

@interface CCTableViewModule7Cell ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *extendLabel;
@property (nonatomic) UIImageView *headImage;
@property (nonatomic) NSMutableArray *images;
@end

@implementation CCTableViewModule7Cell
- (void)setup {
    [super setup];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"模块标题";
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_titleLabel];
    }
    
    if (!_extendLabel) {
        _extendLabel = [[UILabel alloc] init];
        _extendLabel.text = @"模块标题";
        _extendLabel.font = [UIFont systemFontOfSize:14.0f];
        _extendLabel.textAlignment = NSTextAlignmentCenter;
        _extendLabel.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:_extendLabel];
    }
    
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.layer.borderWidth = 1.0f;
        _headImage.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:_headImage];
    }
    
    if (!_images) {
        _images = [NSMutableArray new];
    }
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_images removeAllObjects];
    
    UIImageView *image = nil; UILabel *name = nil;
    UILabel *price1 = nil; UILabel *price2 = nil;
    for (NSInteger i = 0; i < 3; i ++) {
        image = [[UIImageView alloc] init];
        image.layer.borderWidth = 1.0f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:image];
        
        name = [[UILabel alloc] init];
        name.text = @"商品名称商品名称很长很长很长的";
        name.font = [UIFont systemFontOfSize:12.0f];
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:name];
        
        price1 = [[UILabel alloc] init];
        price1.textAlignment = NSTextAlignmentCenter;
        price1.layer.borderWidth = 1.0f;
        price1.layer.borderColor = [UIColor blackColor].CGColor;
        price1.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:price1];
        
        NSMutableAttributedString *mutableAs = [NSMutableAttributedString new];
        {
            NSDictionary *attributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:11.0f],
                                         NSForegroundColorAttributeName: [UIColor colorWithRGB:0xf13f79],
                                         };
            NSAttributedString *as = [[NSAttributedString alloc] initWithString:@"￥" attributes:attributes];
            [mutableAs appendAttributedString:as];
        }
        {
            NSDictionary *attributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:15.0f],
                                         NSForegroundColorAttributeName: [UIColor colorWithRGB:0xf13f79],
                                         };
            NSAttributedString *as = [[NSAttributedString alloc] initWithString:@"999" attributes:attributes];
            [mutableAs appendAttributedString:as];
        }
        {
            NSDictionary *attributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:11.0f],
                                         NSForegroundColorAttributeName: [UIColor colorWithRGB:0x98989f],
                                         };
            NSAttributedString *as = [[NSAttributedString alloc] initWithString:@" 起x12期" attributes:attributes];
            [mutableAs appendAttributedString:as];
        }
        price1.attributedText = mutableAs;
        
        price2 = [[UILabel alloc] init];
        price2.text = @"唯品价¥9999999";
        price2.font = [UIFont systemFontOfSize:11.0f];
        price2.textAlignment = NSTextAlignmentCenter;
        price2.textColor = [UIColor colorWithRGB:0x585c64];
        [self.contentView addSubview:price2];
        
        id obj = @{
          @"image": image,
          @"name": name,
          @"price1": price1,
          @"price2": price2
        };
        [_images addObject:obj];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRGB:0xf3f4f5] set];
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 8));
    
    [[UIColor colorWithRGB:0xf0f0f0] set];
    CGContextMoveToPoint(context, 0, rect.size.height - 44);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 44);
    CGContextStrokePath(context);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 15, 200, 28);
    
    CGFloat margin = 15.0f;
    CGFloat image_witdh = 345.0f;
    CGFloat image_height = 165.0f;
    CGFloat start_y = 44.0f + 8.0f;
    CGSize boundsSize = self.bounds.size;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = image_witdh * screenWidth / 375;
    CGFloat height = width * image_height / image_witdh;
    
    _headImage.frame = CGRectMake(margin, start_y, width, height);
    
    image_witdh = 107.5f;
    image_height = 122.0f;
    start_y = start_y + height + 17.5;
    width = image_witdh * screenWidth / 375;
    height = width * image_height / image_witdh;
    CGFloat space = (screenWidth - margin * 2 - width * 3) / 2;
    
    UIImageView *image = nil; UILabel *name = nil;
    UILabel *price1 = nil; UILabel *price2 = nil;
    for (NSInteger i = 0; i < _images.count; i ++) {
        NSDictionary *info = [_images objectAtIndex:i];
        image = info[@"image"]; name = info[@"name"];
        price1 = info[@"price1"]; price2 = info[@"price2"];
        
        CGFloat x = margin + (width + space) * i;
        image.frame = CGRectMake(x, start_y, width, height);
        
        CGFloat y = start_y + height + 14.0f;
        name.frame = CGRectMake(x, y, width, 12);
        
        y = y + 12 + 8;
        price1.frame = CGRectMake(x, y, width, 16);
        
        y = y + 15 + 8;
        price2.frame = CGRectMake(x, y, width, 11);
    }
    
    _extendLabel.frame = CGRectMake(0, boundsSize.height - 44, boundsSize.width, 44);
}
@end

@interface CCTableViewModule8Cell () <UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSMutableArray *images;
@property (nonatomic) BOOL isScheduled;
@property (nonatomic) BOOL isCancelled;
@end

@implementation CCTableViewModule8Cell
- (void)setup {
    [super setup];
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_scrollView];
    }
    
    CGFloat image_witdh = 375.0f; CGFloat image_height = 150.0f;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = image_witdh * screenWidth / 375;
    CGFloat height = width * image_height / image_witdh;
    
    _scrollView.frame = CGRectMake(0, 0, width, height);

    if (!_images) {
        _images = [NSMutableArray new];
    }
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_images removeAllObjects];

    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = 0;
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor redColor];
        CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
        _pageControl.center = CGPointMake( self.contentView.center.x, height - size.height/2);
        [self.contentView addSubview:_pageControl];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(CCTableViewModuleCellModel *)model {
    [super setModel:model];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 150.0f / 375.0f;
    
    [_images removeAllObjects];
    [_images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSArray *colors = @[[UIColor redColor],[UIColor blueColor]];
    
    CGFloat offset_x = 0;
    UIImageView *image = nil;
    NSInteger count = [colors count];
    for (NSInteger i = 0; i < count; i ++) {
        if (i == 0) {
            image = [[UIImageView alloc] init];
            image.backgroundColor = colors[count - 1 - i];
            image.layer.borderWidth = 1.0f;
            image.layer.borderColor = [UIColor blackColor].CGColor;
            image.frame = CGRectMake(offset_x, 0, width, height);
            offset_x = offset_x + width;
            [_scrollView addSubview:image];
        }
        
        image = [[UIImageView alloc] init];
        image.backgroundColor = colors[i];
        image.layer.borderWidth = 1.0f;
        image.layer.borderColor = [UIColor blackColor].CGColor;
        image.frame = CGRectMake(offset_x, 0, width, height);
        offset_x = offset_x + width;
        [_scrollView addSubview:image];
        [_images addObject:image];
        
        if (i == count - 1) {
            image = [[UIImageView alloc] init];
            image.backgroundColor = colors[count - 1 - i];
            image.layer.borderWidth = 1.0f;
            image.layer.borderColor = [UIColor blackColor].CGColor;
            image.frame = CGRectMake(offset_x, 0, width, height);
            offset_x = offset_x + width;
            [_scrollView addSubview:image];
        }
    }

    _scrollView.contentSize = CGSizeMake(offset_x, height);
    _scrollView.contentOffset = CGPointMake(width, 0);
    
    _pageControl.numberOfPages = count;
    CGPoint point = _pageControl.center;
    _pageControl.center = CGPointMake(self.contentView.center.x, point.y);
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    NSInteger x = scrollView.contentOffset.x;
    if ( x % width == 0) {
        NSInteger count = _images.count;
        NSInteger pages = x / width + count;
        _pageControl.currentPage = (pages - 1) % count;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger count = [_images count];
    CGPoint point = scrollView.contentOffset;
    CGFloat width = scrollView.frame.size.width;
    if (point.x < width) {
        CGRect rect = CGRectMake(width * count + point.x, 0, width, 1);
        [scrollView scrollRectToVisible:rect animated:NO];
    } else if (point.x > width * count) {
        CGRect rect = CGRectMake(width, 0, width, 1);
        [scrollView scrollRectToVisible:rect animated:NO];
    }
    [self start];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stop];
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self start];
    } else {
        [self stop];
    }
}

- (void)removeFromSuperview{
    [self stop];
    [super removeFromSuperview];
}

- (void)start{
    [self stop];
    if (_images.count > 1) {
        _isScheduled = true;
        [self performSelector:@selector(gotoNext) withObject:nil afterDelay:4.0];
    }
}

- (void)stop{
    if (_isScheduled) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(gotoNext) object:nil];
    }
    _isScheduled = false;
}

- (void)gotoNext {
    _isScheduled = false;
    NSInteger count = _images.count;
    if (count > 1) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGPoint point = _scrollView.contentOffset;
        if (point.x >= width * count + width) {
            _scrollView.contentOffset = CGPointMake(width, 0);
            CGRect rect = CGRectMake(width * 2, 0, width, 1);
            [_scrollView scrollRectToVisible:rect animated:YES];
        } else if (point.x >= width * count) {
            _scrollView.contentOffset = CGPointMake(0, 0);
            CGRect rect = CGRectMake(width, 0, width, 1);
            [_scrollView scrollRectToVisible:rect animated:YES];
        } else {
            CGRect rect = CGRectMake(point.x + width, 0, width, 1);
            [_scrollView scrollRectToVisible:rect animated:YES];
        }
        [self start];
    }
}

@end
