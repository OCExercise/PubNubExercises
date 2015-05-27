//
//  ViewController.m
//  HelloMobile
//
//  Created by Presley Cannady on 5/22/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // #1 Define client configuration
    
    PNConfiguration *myConfig = [PNConfiguration configurationForOrigin:@"pubsub.pubnub.com"
                                                             publishKey:@"demo"
                                                           subscribeKey:@"demo"
                                                              secretKey:nil];
    [PubNub setConfiguration:myConfig];
    [PubNub connect];
    
    PNChannel *my_channel = [PNChannel channelWithName:@"a"
                                 shouldObservePresence:YES];
    
    [[PNObservationCenter defaultCenter] addClientConnectionStateObserver:self withCallbackBlock:^(NSString *origin, BOOL connected, PNError *connectionError){
        if (connected)
        {
            NSLog(@"OBSERVER: Successful Connection!");
            [PubNub subscribeOn:@[my_channel]];
        }
        else if (!connected || connectionError)
        {
            NSLog(@"OBSERVER: Error %@, Connection Failed!", connectionError.localizedDescription);
        }
    }];
    
    [[PNObservationCenter defaultCenter] addClientChannelSubscriptionStateObserver:self withCallbackBlock:^(PNSubscriptionProcessState state, NSArray *channels, PNError *error){
        switch (state) {
            case PNSubscriptionProcessSubscribedState:
                NSLog(@"OBSERVER: Subscribed to Channel: %@", channels[0]);
                break;
            case PNSubscriptionProcessNotSubscribedState:
                NSLog(@"OBSERVER: Not subscribed to Channel: %@, Error: %@", channels[0], error);
                break;
            case PNSubscriptionProcessWillRestoreState:
                NSLog(@"OBSERVER: Will re-subscribe to Channel: %@", channels[0]);
                break;
            case PNSubscriptionProcessRestoredState:
                NSLog(@"OBSERVER: Re-subscribed to Channel: %@", channels[0]);
                break;
        }
    }];
    
    [[PNObservationCenter defaultCenter] addClientChannelUnsubscriptionObserver:self withCallbackBlock:^(NSArray *channel, PNError *error) {
        if ( error == nil )
        {
            NSLog(@"OBSERVER: Unsubscribed from Channel: %@", channel[0]);
            [PubNub subscribeOn:@[my_channel]];
        }
        else
        {
            NSLog(@"OBSERVER: Unsubscribed from Channel: %@, Error: %@", channel[0], error);
        }
    }];

    
    [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self withBlock:^(PNMessage *message) {
        NSLog(@"OBSERVER: Channel: %@, Message: %@", message.channel.name, message.message);
    }];
    
    [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self withBlock:^(PNMessage *message) {
        NSLog(@"OBSERVER: Channel: %@, Message: %@", message.channel.name, message.message);
        if ( [[[NSString stringWithFormat:@"%@", message.message] substringWithRange:NSMakeRange(1,14)] isEqualToString: @"**************" ])
        {
            [PubNub sendMessage:[NSString stringWithFormat:@"Thank you, GOODBYE!" ] toChannel:my_channel withCompletionBlock:^(PNMessageState messageState, id data) {
                if (messageState == PNMessageSent) {
                    NSLog(@"OBSERVER: Sent Goodbye Message!");
                    [PubNub unsubscribeFrom:@[my_channel] ];
                }
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
