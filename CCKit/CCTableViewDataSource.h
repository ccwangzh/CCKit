//
//  CCTableViewDataSource.h
//  CCKit
//
//  Created by can on 17/1/17.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCTableViewDataSource <UITableViewDataSource>
@property (readonly) NSUInteger count;
- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
@end

@protocol CCTableViewSection <NSObject>
@property (readonly) NSUInteger count;
- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
@end

@protocol CCTableViewCellModel <NSObject>
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) NSString *cellId;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@protocol CCTableViewCell <NSObject>
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) id<CCTableViewCellModel> model;
@end

@interface CCTableViewDataSource : NSObject <CCTableViewDataSource>
{
    __strong NSMutableArray *_sections;
}
@end

@interface CCTableViewSection : NSObject <CCTableViewSection>
{
    __strong NSMutableArray *_cells;
}
@end

@interface CCTableViewCellModel : NSObject <CCTableViewCellModel>
{
    __strong Class _cellClass;
    __strong NSString *_cellId;
    CGFloat _cellHeight;
}
@end

@interface CCTableViewCell : UITableViewCell <CCTableViewCell>
{
    __weak id _delegate;
    __strong id<CCTableViewCellModel> _model;
}
- (void)setup;
@end
