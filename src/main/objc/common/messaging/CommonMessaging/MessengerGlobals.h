//
//  MessengerGlobals.h
//  CommonMessaging
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#ifdef DEBUG
#   ifndef DLog
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#   endif
#else
#   ifndef DLog
#   define DLog(...)
#   endif
#endif

// ALog always displays output regardless of the DEBUG setting
#ifndef RLog
#define RLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef CommonMessaging_MessengerGlobals_h
#define CommonMessaging_MessengerGlobals_h


#endif
