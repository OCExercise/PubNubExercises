//
//  AppDelegate.h
//  MessengerOSX
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <CommonMessaging/CommonMessagingImports.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, retain) MessengerChannel * locker;

@end

