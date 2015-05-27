//
//  Messengerer.m
//  MessengerOSX
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "MessengerChannel.h"

@implementation MessengerChannel

# pragma mark - Initialization

- (instancetype) init
{
    if (self = [super init])
    {
        [PubNub setDelegate:self];
        
    }
    
    return self;
}

+ (instancetype) sharedInstance {
    static MessengerChannel * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MessengerChannel alloc] init];
    });
    
    return sharedInstance;
}

# pragma mark - PNDelegate implementation

- (void)pubnubClient:(PubNub *)client didConnectToOrigin:(NSString *)origin {
    DLog(@"DELEGATE: Connected to  origin: %@", origin);
}

- (void)pubnubClient:(PubNub *)client didSubscribeOnChannels:(NSArray *)channels {
    DLog(@"DELEGATE: Subscribed to channel:%@", channels);
}

- (void)pubnubClient:(PubNub *)client didReceiveMessage:(PNMessage *)message {
    DLog(@"DELEGATE: Message received.");
}

# pragma mark - Connection

+ (PNConfiguration * ) defaultConfiguration {
    
    NSString * origin = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MessengerOrigin"];
    NSString * publishKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MessengerPublishKey"];
    NSString * subscribeKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MessengerSubscribeKey"];
    NSString * secretKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MessengerSecretKey"];

    
    PNConfiguration * config = [PNConfiguration configurationForOrigin:origin
                                                            publishKey:publishKey
                                                          subscribeKey:subscribeKey
                                                             secretKey:secretKey];
    
    return config;
    
}

- (void) connect {
    PNConfiguration * config = [MessengerChannel defaultConfiguration];
    [self connect:config];
}

- (void) connect:(PNConfiguration *) config {
    
    [PubNub setConfiguration:config];
    [PubNub connect];
    
    
    PNChannel * remote_channel = [PNChannel channelWithName:@"a"
                                      shouldObservePresence:YES];
    
    [[PNObservationCenter defaultCenter] addClientConnectionStateObserver:self withCallbackBlock:^(NSString *origin, BOOL connected, PNError *connectionError){
        if (connected)
        {
            DLog(@"OBSERVER: Successful Connection!");
            [PubNub subscribeOn:@[remote_channel]];
        }
        else if (!connected || connectionError)
        {
            DLog(@"OBSERVER: Error %@, Connection Failed!", connectionError.localizedDescription);
        }
        
        [self.delegate locker:self didConnect:connectionError];
    }];
    
    [[PNObservationCenter defaultCenter] addClientChannelSubscriptionStateObserver:self withCallbackBlock:^(PNSubscriptionProcessState state, NSArray *channels, PNError *error){
        switch (state) {
            case PNSubscriptionProcessSubscribedState:
                DLog(@"OBSERVER: Subscribed to Channel: %@", channels[0]);
                break;
            case PNSubscriptionProcessNotSubscribedState:
                DLog(@"OBSERVER: Not subscribed to Channel: %@, Error: %@", channels[0], error);
                break;
            case PNSubscriptionProcessWillRestoreState:
                DLog(@"OBSERVER: Will re-subscribe to Channel: %@", channels[0]);
                break;
            case PNSubscriptionProcessRestoredState:
                DLog(@"OBSERVER: Re-subscribed to Channel: %@", channels[0]);
                break;
        }
        
        [self.delegate locker:self didConnect:error];
    }];
    
    [[PNObservationCenter defaultCenter] addClientChannelUnsubscriptionObserver:self withCallbackBlock:^(NSArray *channel, PNError *error) {
        if ( error == nil )
        {
            DLog(@"OBSERVER: Unsubscribed from Channel: %@", channel[0]);
            [PubNub subscribeOn:@[remote_channel]];
        }
        else
        {
            DLog(@"OBSERVER: Unsubscribed from Channel: %@, Error: %@", channel[0], error);
        }
        
        [self.delegate locker:self didConnect:error];
    }];
    
    
    [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self withBlock:^(PNMessage *message) {
        DLog(@"OBSERVER: Channel: %@, Message: %@", message.channel.name, message.message);
        if ( [[[NSString stringWithFormat:@"%@", message.message] substringWithRange:NSMakeRange(1,14)] isEqualToString: @"**************" ])
        {
            [PubNub sendMessage:[NSString stringWithFormat:@"Thank you, GOODBYE!" ] toChannel:remote_channel withCompletionBlock:^(PNMessageState messageState, id data) {
                if (messageState == PNMessageSent) {
                    DLog(@"OBSERVER: Sent Goodbye Message!");
                    [PubNub unsubscribeFrom:@[remote_channel] ];
                }
            }];
        }
        
        [self.delegate locker:self didConnect:nil];
    }];
}

@end
