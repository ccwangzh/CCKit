//
//  CCKVStore.m
//  CCKit
//
//  Created by can on 17/2/15.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#import "CCKVStore.h"

#import <sqlite3.h>

NSString *CCSqliteEscape(NSString *string) {
    if (string == nil || string.length == 0) return string;
    NSString *escapedString = [string stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return escapedString;
}

@interface CCKVStore ()
{
    sqlite3             *_db;
    NSString            *_databasePath;
    BOOL                _isExecuting;
    
    NSMutableDictionary *_schemaVersions;
    NSMutableDictionary *_pendingVersions;
}
@end

@implementation CCKVStore
+ (instancetype)store {
    return [[self alloc] initWithName:@"default.db"];
}
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _db = NULL;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths firstObject] stringByAppendingPathComponent:@"KVStore"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        BOOL isExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
        if (!isExists) {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:NULL error:NULL];
        }  else if (isExists && !isDirectory) {
            [fileManager removeItemAtPath:path error:NULL];
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
        NSString *databasePath = [path stringByAppendingPathComponent:name];
        isExists = [fileManager fileExistsAtPath:databasePath isDirectory:&isDirectory];
        if (isExists && isDirectory) {
            [fileManager removeItemAtPath:databasePath error:NULL];
        }
        NSLog(@"databasePath:%@", databasePath);
        _databasePath = databasePath;
        
        BOOL isOpen = [self open];
        if (isOpen) {
            [self initDatabase];
            [self migrateDatabase];
        }
    }
    return self;
}

- (void)setObject:(NSString *)object forKey:(NSString *)key {
    long updated = [[NSDate new] timeIntervalSince1970];
    NSString *value = CCSqliteEscape(object); key = CCSqliteEscape(key);
    NSString *sql = @"INSERT OR REPLACE INTO 'dictionary' (key, value, updated) VALUES ('%@', '%@', %ld);";
    [self executeUpdate:[NSString stringWithFormat:sql, key, value ? value : @"", updated]];
}

- (NSString *)objectForKey:(NSString *)key {
    __block NSString *value = nil;
    key = CCSqliteEscape(key);
    NSString *sql = [NSString stringWithFormat:@"SELECT value FROM 'dictionary' WHERE key = '%@';",key];
    [self executeQuery:sql withCallback:^(sqlite3_stmt *pStmt) {
        if (sqlite3_step(pStmt) == SQLITE_ROW) {
            const char *str = (const char *)sqlite3_column_text(pStmt, 0);
            if (str && strlen(str)) {
                value = [NSString stringWithUTF8String:str];
            }
        }
    }];
    if (value) {
        long visited = [[NSDate new] timeIntervalSince1970];
        sql = [NSString stringWithFormat:@"UPDATE 'dictionary' SET visited = %ld WHERE key = '%@';", visited, key];
        [self executeUpdate:sql];
    }
    return value;
}

- (void)removeObjectForKey:(NSString *)key {
    key = CCSqliteEscape(key);
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM 'dictionary' WHERE key = '%@';",key];
    [self executeUpdate:sql];
}

- (BOOL)containsObjectForKey:(NSString *)key {
    __block BOOL contains = NO;
    key = CCSqliteEscape(key);
    NSString *sql = [NSString stringWithFormat:@"SELECT value FROM 'dictionary' WHERE key = '%@';",key];
    [self executeQuery:sql withCallback:^(sqlite3_stmt *pStmt) {
        if (sqlite3_step(pStmt) == SQLITE_ROW) {
            const char *str = (const char *)sqlite3_column_text(pStmt, 0);
            if (str && strlen(str)) {
                contains = YES;
            }
        }
    }];
    return contains;
}

- (const char *)sqlitePath {
    if (!_databasePath) {
        return ":memory:";
    }
    
    if ([_databasePath length] == 0) {
        return ""; // this creates a temporary database (it's an sqlite thing).
    }
    
    return [_databasePath fileSystemRepresentation];
}

- (BOOL)open {
    if (_db) {
        return YES;
    }
    
    int err = sqlite3_open([self sqlitePath], (sqlite3**)&_db );
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }
    
    return YES;
}

- (BOOL)close {
    if (!_db) {
        return YES;
    }
    
    int rc = sqlite3_close(_db);
    _db = nil;
    
    return rc == SQLITE_OK;
}

- (BOOL)executeQuery:(NSString *)sql withCallback:(void (^)(sqlite3_stmt *pStmt)) callback {
    if (_db == NULL || _isExecuting) return NO;
    
    _isExecuting = YES;
    
    int rc                  = 0x00;
    sqlite3_stmt *pStmt     = 0x00;
    
    rc = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &pStmt, 0);
    
    if (SQLITE_OK == rc && callback) {
        callback(pStmt);
    }
    
    sqlite3_finalize(pStmt);
    _isExecuting = NO;
    
    return (rc == SQLITE_DONE || rc == SQLITE_OK);
}

- (BOOL)executeUpdate:(NSString *)sql {
    if (_db == NULL || _isExecuting) return NO;
    
    _isExecuting = YES;
    
    int rc                  = 0x00;
    sqlite3_stmt *pStmt     = 0x00;
    
    rc = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &pStmt, 0);
    
    rc = sqlite3_step(pStmt);
    
    sqlite3_finalize(pStmt);
    _isExecuting = NO;
    
    return (rc == SQLITE_DONE || rc == SQLITE_OK);
}

- (BOOL)hasMigrationsTable
{
    __block BOOL hasMigrationsTable = NO;
    NSString *sql = @"SELECT name FROM sqlite_master WHERE type='table' AND name='schema_versions' limit 1;";
    [self executeQuery:sql withCallback:^(sqlite3_stmt *pStmt) {
        int rc = sqlite3_step(pStmt);
        if (rc == SQLITE_ROW) {
            hasMigrationsTable = YES;
            const char *str = (const char *)sqlite3_column_text(pStmt, 0);
            NSString *string = [NSString stringWithUTF8String:str];
            NSLog(@"%@", string);
        }
    }];
    return hasMigrationsTable;
}

- (BOOL)createMigrationsTable
{
    return [self executeUpdate:@"CREATE TABLE schema_versions(version INTEGER UNIQUE NOT NULL);"];
}

- (NSMutableDictionary *)schemaVersions {
    if (_schemaVersions) {
        return _schemaVersions;
    }
    _schemaVersions = [NSMutableDictionary new];
    _schemaVersions[@(2017021601)] = @"CREATE TABLE dictionary(key TEXT NOT NULL PRIMARY KEY, value TEXT, extend TEXT, updated INTEGER, visited INTEGER);";
    return _schemaVersions;
}

- (NSDictionary *)pendingVersions {
    uint64_t currentVersion = [self currentVersion];
    NSMutableDictionary *schemaVersions = [self schemaVersions];
    NSArray *schemaVersionsKeys = [schemaVersions allKeys];
    
    NSMutableDictionary *versions = [NSMutableDictionary new];
    for (NSInteger i = 0; i < [schemaVersionsKeys count]; i ++) {
        id key = [schemaVersionsKeys objectAtIndex:i];
        if ([key longValue] > currentVersion) {
            versions[key] = schemaVersions[key];
        }
    }
    
    return versions;
}

- (uint64_t)currentVersion
{
    __block  uint64_t version = 0;
    NSString *sql = @"SELECT MAX(version) FROM schema_versions";
    [self executeQuery:sql withCallback:^(sqlite3_stmt *pStmt) {
        if (sqlite3_step(pStmt) == SQLITE_ROW) {
            version = sqlite3_column_int64(pStmt, 0);
        }
    }];
    return version;;
}

- (void)migrateDatabase {
    if (![self hasMigrationsTable]) {
        [self createMigrationsTable];
    }
    NSDictionary *pendingVersions = [self pendingVersions];
    if ([pendingVersions count] > 0) {
        NSArray *schemaVersionsKeys = [pendingVersions allKeys];
        schemaVersionsKeys = [schemaVersionsKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 longValue] > [obj2 longValue];
        }];
        for (NSInteger i = 0; i < [schemaVersionsKeys count]; i ++) {
            id key = [schemaVersionsKeys objectAtIndex:i];
            NSString *schemaSql = pendingVersions[key];
            NSString *updateSql = [NSString stringWithFormat:@"INSERT INTO schema_versions(version) VALUES (%ld);", [key longValue]];
            [self executeUpdate:updateSql];
            [self executeUpdate:schemaSql];
        }
    }
}

- (void)initDatabase {
    NSString *sql = @"PRAGMA journal_mode = wal; PRAGMA synchronous = normal;";
    [self executeUpdate:sql];
}

@end
