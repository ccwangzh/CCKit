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

@interface CCTableViewEditViewController : XLFormViewController
@end

@interface CCTableViewTaskModel : NSObject
@property (nonatomic) NSInteger index;
@property (nonatomic) NSString *url;
@property (nonatomic) NSInteger interval;
@end
@interface CCTableViewTaskManager : NSObject
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
    controller = [[CCTableViewEditViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end

@implementation CCTableViewEditViewController
- (instancetype)init {
    XLFormDescriptor *form = nil;
    XLFormSectionDescriptor *section = nil;
    XLFormRowDescriptor *row = nil;
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"Edit"];
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"URL" rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"URL" forKey:@"textView.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    // Repeat
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"repeat" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Repeat"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Never"];
    row.selectorTitle = @"Repeat";
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Never"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Every Day"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Every Week"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Every 2 Weeks"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Every Month"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(5) displayText:@"Every Year"],
                            ];
    [section addFormRow:row];
    
    return [super initWithForm:form style:UITableViewStylePlain];
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
