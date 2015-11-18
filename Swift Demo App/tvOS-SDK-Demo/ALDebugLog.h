//
//  ALDebugLog.h
//  tvOS-SDK-Demo
//
//  Created by Thomas So on 11/13/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#ifndef tvOS_Test_App_NG_ALDebugLog_h
#define tvOS_Test_App_NG_ALDebugLog_h

#ifdef DEBUG
    #define ALLog(str, ...) NSLog(str, ##__VA_ARGS__)
#else
    #define ALLog(str, ...)
#endif

#endif
