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
+ (instancetype)sharedManager;
- (void)save:(CCTableViewTaskModel *)model;
- (NSArray *)queryAll;
@end

@interface CCTableViewFormCellModel : CCTableViewCellModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id userInfo;
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
    
    CCTableViewDataSource *dataSource = nil;
    dataSource = [CCTableViewDataSource new];
    self.dataSource = dataSource;
    
    CCTableViewSection *section = nil;
    section = [CCTableViewSection new];
    [dataSource addObject:section];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CCTableViewSection *section = nil;
    section = [self.dataSource objectAtIndex:0];
    [section removeAllObjects];
    
    CCTableViewTaskManager *manager = nil;
    manager = [CCTableViewTaskManager sharedManager];
    NSArray *list = [manager queryAll];
    CCTableViewFormCellModel *model = nil;
    
    for (CCTableViewTaskModel *task in list) {
        model = [CCTableViewFormCellModel new];
        model.title = task.url;
        model.userInfo = task;
        [section addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)rightButtonDidClicked:(id)sender {
    CCTableViewEditViewController *controller = nil;
    CCTableViewTaskModel *model = [CCTableViewTaskModel new];
    model.url = @"https://m.baidu.com/";
    model.interval = 60;
    controller = [[CCTableViewEditViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCTableViewSection *section = [self.dataSource objectAtIndex:0];
    CCTableViewFormCellModel *model = [section objectAtIndex:indexPath.row];
    CCTableViewTaskModel *task = model.userInfo;
    CCTableViewEditViewController *controller = nil;
    controller = [[CCTableViewEditViewController alloc] initWithModel:task];
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
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"url" rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"url" forKey:@"textView.placeholder"];
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
    
    NSDictionary *values = self.formValues;
    CCTableViewTaskModel *model = self.model;
    model.url = values[@"url"];
    model.interval = [values[@"repeat"] integerValue];
    [[CCTableViewTaskManager sharedManager] save:model];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

@implementation CCTableViewTaskModel

@end

@interface CCTableViewTaskEngine : UIWebView <UIWebViewDelegate>
@property (nonatomic) void(^completionHandler)(void);
- (void)runWithModel:(CCTableViewTaskModel *)model completionHandler:(void(^)(void))completionHandler;
@end
@implementation CCTableViewTaskEngine
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}
- (void)runWithModel:(CCTableViewTaskModel *)model completionHandler:(void(^)(void))completionHandler {
    NSURL *url = [NSURL URLWithString:model.url];
    if (url) {
        self.completionHandler = completionHandler;
        [self loadRequest:[NSURLRequest requestWithURL:url]];
    } else {
        if (completionHandler) {
            completionHandler();
        }
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.completionHandler) {
            self.completionHandler();
        }
    });
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.completionHandler) {
            self.completionHandler();
        }
    });
}
- (NSString *)readNum3 {
   return [self stringByEvaluatingJavaScriptFromString:@"document.getElementById('readNum3').innerHTML"];
}
- (NSString *)likeNum3 {
    return [self stringByEvaluatingJavaScriptFromString:@"document.getElementById('likeNum3').innerHTML"];
}
@end
@interface CCTableViewTaskManager ()
@property (nonatomic, assign) BOOL running;
@property (nonatomic) NSMutableArray *runnings;
@property (nonatomic) CCTableViewTaskEngine *engine;
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
        CCTableViewTaskModel *model = nil;
        for (NSInteger i = 0; i < tasks.count; i ++) {
            NSDictionary *task = [tasks objectAtIndex:i];
            model = [CCTableViewTaskModel yy_modelWithDictionary:task];
            [_tasks addObject:model];
        }
        self.path = path;
        NSLog(@"%@", path);
        
        self.runnings = [NSMutableArray new];
        self.engine = [CCTableViewTaskEngine new];
        [self schedule];
    }
    return self;
}

- (void)schedule {
//    [self performSelector:@selector(schedule)
//               withObject:nil afterDelay:10.0];
    
    if (self.running) return;
    self.running = YES;
    
    CCTableViewTaskModel *model = nil;
    model = [self nextObject];
    if (model) {
        __weak typeof(self) weakRef = self;
        [self.engine runWithModel:model completionHandler:^{
            __strong typeof(weakRef) strongRef = weakRef;
            NSString *readNum3 = [strongRef.engine readNum3];
            NSString *likeNum3 = [strongRef.engine likeNum3];
            NSLog(@"num:%@,%@", readNum3, likeNum3);
        }];
    } else {
        self.running = NO;
    }
}

- (CCTableViewTaskModel *)nextObject {
    CCTableViewTaskModel *model = nil;
    NSMutableArray *runnings = self.runnings;
    if (runnings.count > 0) {
        model = [runnings firstObject];
        [runnings removeObjectAtIndex:0];
        return model;
    }
    [runnings addObjectsFromArray:_tasks];
    if (runnings.count > 0) {
        model = [runnings firstObject];
        [runnings removeObjectAtIndex:0];
    }
    return model;
}

- (void)save:(CCTableViewTaskModel *)model {
    if (model == nil) return;
    CCTableViewTaskModel *task = nil;
    NSMutableArray *tasks = _tasks;
    if (model.index == 0) {
        if (tasks.count == 0) {
            model.index = 1;
        } else {
            task = [tasks lastObject];
            model.index = task.index + 1;
        }
        [tasks addObject:model];
    } else {
        for (NSInteger i = 0; i < tasks.count; i ++) {
            task = [tasks objectAtIndex:i];
            if (task.index == model.index) {
                [tasks replaceObjectAtIndex:i withObject:model];
                break;
            }
        }
    }
    [self synchronize];
}

- (CCTableViewTaskModel *)queryWithIndex:(NSInteger)index {
    NSMutableArray *tasks = _tasks;
    CCTableViewTaskModel *model = nil;
    for (NSInteger i = 0; i < tasks.count; i ++) {
        CCTableViewTaskModel *task = tasks[i];
        if (task.index == index) {
            model = task;
            break;
        }
    }
    return model;
}

- (NSArray *)queryAll {
    NSMutableArray *tasks = _tasks;
    return [tasks copy];
}

- (void)synchronize {
    NSMutableArray *list = [NSMutableArray new];
    CCTableViewTaskModel *model = nil;
    NSMutableArray *tasks = _tasks;
    for (NSInteger i = 0; i < tasks.count; i ++) {
        model = [tasks objectAtIndex:i];
        [list addObject:[model yy_modelToJSONObject]];
    }
    [list writeToFile:self.path atomically:YES];
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
