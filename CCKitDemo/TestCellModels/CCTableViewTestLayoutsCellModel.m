//
//  CCTableViewTestLayoutsCellModel.m
//  CCKit
//
//  Created by can on 17/8/23.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCTableViewTestLayoutsCellModel.h"

@interface CCTableViewTestCollectionViewController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@interface CCTableViewTestCollectionViewLayout : UICollectionViewFlowLayout

@end

@implementation CCTableViewTestLayoutsCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"测试：Layouts";
    }
    return self;
}

- (void)doTest {
    NSLog(@"doTest");
    UIApplication *application = [UIApplication sharedApplication];
    UIViewController *rootController = [application keyWindow].rootViewController;
    UITabBarController *tabController = (UITabBarController *)rootController;
    UINavigationController *navController = [tabController selectedViewController];
    
    CCTableViewTestCollectionViewController *testController = nil;
    testController = [CCTableViewTestCollectionViewController new];
    testController.hidesBottomBarWhenPushed = YES;
    [navController pushViewController:testController animated:YES];
}
@end

@implementation CCTableViewTestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CCTableViewTestCollectionViewLayout *collectionViewLayout = nil;
    collectionViewLayout = [CCTableViewTestCollectionViewLayout new];
    
    UICollectionView *collectionView = nil;
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                        collectionViewLayout:collectionViewLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    NSString *cellIdentifier = NSStringFromClass([UICollectionViewCell class]);
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    

    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([UICollectionViewCell class]);
    UICollectionViewCell *otherCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    otherCell.backgroundColor = [UIColor blueColor];
    return otherCell;
}

@end

@implementation CCTableViewTestCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];

    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
    
    return layoutAttributes;
}

@end
