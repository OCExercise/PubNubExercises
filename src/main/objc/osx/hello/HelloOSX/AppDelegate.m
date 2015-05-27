//
//  AppDelegate.m
//  HelloOSX
//
//  Created by Presley Cannady on 5/22/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)pubnubClient:(PubNub *)client didConnectToOrigin:(NSString *)origin {
    NSLog(@"DELEGATE: Connected to  origin: %@", origin);
}

- (void)pubnubClient:(PubNub *)client didSubscribeOnChannels:(NSArray *)channels {
    NSLog(@"DELEGATE: Subscribed to channel:%@", channels);
}

- (void)pubnubClient:(PubNub *)client didReceiveMessage:(PNMessage *)message {
    NSLog(@"DELEGATE: Message received.");
}


@end
