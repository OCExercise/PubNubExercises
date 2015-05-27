//
//  MessengerChannelDelegate.h
//  CommonMessaging
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MessengerGlobals.h"
#import "MessengerChannel.h"

@class MessengerChannel;

@protocol MessengerChannelDelegate <NSObject>


- (void) locker:(MessengerChannel *) locker didConnect:(NSError * ) error;
- (void) locker:(MessengerChannel *) locker didReceive:(NSError * ) error;

@end
