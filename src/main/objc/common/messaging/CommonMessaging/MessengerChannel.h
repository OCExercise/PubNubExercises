//
//  MessengerChannel.h
//  MessengerOSX
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <PubNub/PNImports.h>

#import "MessengerGlobals.h"
#import "MessengerChannelDelegate.h"

@interface MessengerChannel : NSObject <PNDelegate>

@property (nonatomic, strong) id<MessengerChannelDelegate> delegate;


+ (instancetype) sharedInstance;


+ (PNConfiguration * ) defaultConfiguration;

- (void) connect;
- (void) connect:(PNConfiguration *) config;

- (NSString *) message;

@end
