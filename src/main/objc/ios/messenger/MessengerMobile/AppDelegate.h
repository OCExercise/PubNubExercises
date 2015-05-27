//
//  AppDelegate.h
//  MessengerMobile
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CommonMessaging/CommonMessagingImports.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) MessengerChannel * locker;

@end

