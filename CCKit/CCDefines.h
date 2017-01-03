//
//  CCDefines.h
//  CCKit
//
//  Created by can on 17/1/3.
//  Copyright © 2017年 womob.com. All rights reserved.
//

#ifndef CCDefines_h
#define CCDefines_h

#if !defined(CCLog)
    #define CCLog(FORMAT, ...) fprintf(stderr, "%s:%d $ %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#endif

#define CCLogLevelDebug                             5
#define CCLogLevelError                             2

#if !defined(CCLogLevel)
    #define CCLogLevel                              CCLogLevelError
#endif

#if (CCLogLevelDebug <= CCLogLevel)
    #define CCLogDebug(format, ...)                 CCLog(format, ##__VA_ARGS__)
#else
    #define CCLogDebug(format, ...)
#endif

#if (CCLogLevelError <= CCLogLevel)
    #define CCLogError(format, ...)                 CCLog(format, ##__VA_ARGS__)
#else
    #define CCLogError(format, ...)
#endif

#endif /* CCDefines_h */
