//
//  CMDbHelper.m
//  CCKitMoney
//
//  Created by can on 2017/12/1.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CMDbHelper.h"
#import <WCDB/WCDB.h>
#import "CMMoney+WCTTableCoding.h"

@interface CMDbHelper ()
@property (nonatomic) WCTDatabase *db;
@end

@implementation CMDbHelper

+ (instancetype)helper {
    static CMDbHelper *_helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _helper = [CMDbHelper new];
    });
    return _helper;
}

- (instancetype)init {
    if (self = [super init]) {
        NSSearchPathDirectory pd = NSDocumentDirectory;
        NSSearchPathDomainMask mask = NSUserDomainMask;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(pd, mask, YES);
        NSString *path = [paths[0] stringByAppendingPathComponent:@"data"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            NSURL *URL = [NSURL fileURLWithPath:path isDirectory:YES];
            [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:NULL];
        }
        path = [path stringByAppendingPathComponent:@"db.sqlite3"];
        self.db = [[WCTDatabase alloc] initWithPath:path];
        
        NSString *tableName = NSStringFromClass(CMMoney.class);
        [self.db createTableAndIndexesOfName:tableName withClass:CMMoney.class];
    }
    return self;
}

- (BOOL)insertObject:(WCTObject *)object {
    NSString *tableName = NSStringFromClass([object class]);
    return [self.db insertObject:object into:tableName];
}

- (id)getOneObjectOfClass:(Class)cls {
    NSString *tableName = NSStringFromClass(cls);
    return [self.db getOneObjectOfClass:cls fromTable:tableName];
}

@end
