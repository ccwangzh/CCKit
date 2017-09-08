//
//  CCTableViewTestXLFormsCellModel.m
//  CCKit
//
//  Created by can on 17/9/8.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestXLFormsCellModel.h"
#import <YYModel/YYModel.h>
#import <XLForm/XLForm.h>

@interface CCTableViewFormsViewController : CCTableViewController
@end
@class CCTableViewTaskModel;
@interface CCTableViewEditViewController : XLFormViewController
- (instancetype)initWithModel:(CCTableViewTaskModel *)model;
@property (nonatomic) CCTableViewTaskModel *model;
@end

@interface CCTableViewTaskModel : NSObject
@property (nonatomic) NSInteger index;
@property (nonatomic) NSString *url;
@property (nonatomic) NSInteger interval;
@end
@interface CCTableViewTaskManager : NSObject
@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) NSString *directory;
@property (nonatomic) NSString *path;
@end

@interface CCTableViewFormCellModel : CCTableViewCellModel
@property (nonatomic, strong) NSString *title;
- (void)setUp;
@end

@interface CCTableViewFormCell : CCTableViewCell
@property (nonatomic, strong) CCTableViewFormCellModel *model;
@end

@implementation CCTableViewTestXLFormsCellModel
+ (void)load {
    CCTableViewTestCellModelRegister(self);
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：XLForms";
    }
    return self;
}

- (void)doTest1 {
    NSLog(@"doTest");

}

- (void)doTest {
    NSLog(@"doTest");
    UIApplication *application = [UIApplication sharedApplication];
    UIViewController *rootController = [application keyWindow].rootViewController;
    UITabBarController *tabController = (UITabBarController *)rootController;
    UINavigationController *navController = [tabController selectedViewController];
    
    CCTableViewFormsViewController *testController = nil;
    testController = [CCTableViewFormsViewController new];
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}

@end

@implementation CCTableViewFormsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                             target:self action:@selector(rightButtonDidClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    CCTableViewDataSource *dataSource = [CCTableViewDataSource new];
    self.dataSource = dataSource;
    
    CCTableViewSection *section = [CCTableViewSection new];
    [dataSource addObject:section];
    
    CCTableViewFormCellModel *model = nil;
    model = [CCTableViewFormCellModel new];
    model.title = @"aaa";
    [section addObject:model];
}

- (void)rightButtonDidClicked:(id)sender {
    CCTableViewEditViewController *controller = nil;
    CCTableViewTaskModel *model = [CCTableViewTaskModel new];
    model.url = @"https://m.baidu.com/";
    model.interval = 60;
    controller = [[CCTableViewEditViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}

@end

@implementation CCTableViewEditViewController
- (instancetype)initWithModel:(CCTableViewTaskModel *)model {
    XLFormDescriptor *form = nil;
    XLFormSectionDescriptor *section = nil;
    XLFormRowDescriptor *row = nil;
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"Edit"];
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"URL" rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"URL" forKey:@"textView.placeholder"];
    row.value = model.url;
    row.required = YES;
    [section addFormRow:row];
    
    // Repeat
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"repeat" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Repeat"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Never"];
    row.selectorTitle = @"Repeat";
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(10) displayText:@"10分钟"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(60) displayText:@"60分钟"],
                            ];
    row.value = @(model.interval);
    [section addFormRow:row];
    
    if (self = [super initWithForm:form style:UITableViewStylePlain]) {
        self.model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                             target:self action:@selector(rightButtonDidClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)rightButtonDidClicked:(id)sender {
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
}
@end

@implementation CCTableViewTaskModel

@end

static CCTableViewTaskManager *_manager;
@implementation CCTableViewTaskManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _tasks = [NSMutableArray new];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths firstObject] stringByAppendingPathComponent:@"task"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        self.directory = path;
        NSLog(@"%@", path);
        
        path = [path stringByAppendingPathComponent:@"tasks.plist"];
        NSArray *tasks = [NSArray arrayWithContentsOfFile:path];
        [_tasks addObjectsFromArray:tasks];
        self.path = path;
        NSLog(@"%@", path);
    }
    return self;
}

- (void)save:(CCTableViewTaskModel *)model {
    if (model == nil) return;
    NSDictionary *task = nil;
    NSMutableArray *tasks = _tasks;
    if (model.index == 0) {
        if (tasks.count == 0) {
            model.index = 1;
        } else {
            task = [tasks lastObject];
            model.index = [task[@"index"] integerValue] + 1;
        }
        [tasks addObject:[model yy_modelToJSONObject]];
    } else {
        for (NSInteger i = 0; i < tasks.count; i ++) {
            NSDictionary *task = tasks[i];
            if ([task[@"index"] integerValue] == model.index) {
                task = [model yy_modelToJSONObject];
                [tasks replaceObjectAtIndex:i withObject:task];
                break;
            }
        }
    }
}

- (CCTableViewTaskModel *)queryWithIndex:(NSInteger)index {
    NSMutableArray *tasks = _tasks;
    CCTableViewTaskModel *model = nil;
    for (NSInteger i = 0; i < tasks.count; i ++) {
        NSDictionary *task = tasks[i];
        if ([task[@"index"] integerValue] == index) {
            model = [CCTableViewTaskModel yy_modelWithDictionary:task];
            break;
        }
    }
    return model;
}

- (NSArray *)queryAll {
    NSMutableArray *tasks = _tasks;
    CCTableViewTaskModel *model = nil;
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < tasks.count; i ++) {
        model = [CCTableViewTaskModel yy_modelWithDictionary:tasks[i]];
        [list addObject:model];
    }
    return list;
}

- (void)synchronize {
    [_tasks writeToFile:self.path atomically:YES];
}

@end

@implementation CCTableViewFormCellModel
- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (NSString *)cellId {
    return @"CCTableViewFormCell";
}

- (CGFloat)cellHeight {
    return 44.0f;
}

- (Class)cellClass {
    return [CCTableViewFormCell class];
}
- (void)setUp{}
@end

@implementation CCTableViewFormCell
@dynamic model;
- (void)setup {
    [super setup];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
- (void)setModel:(CCTableViewFormCellModel *)model {
    _model = model;
    self.textLabel.text = model.title;
}
@end
