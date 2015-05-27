//
//  ViewController.m
//  MessengerOSX
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property (nonatomic, strong) IBOutlet NSTextView * console;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    AppDelegate * delegate = (AppDelegate * )[[NSApplication sharedApplication] delegate];
    
    delegate.locker.delegate = self;
    [delegate.locker connect];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void) locker:(id)locker didConnect:(NSError *)error {
    if (error) {
        DLog(@"%@", error.localizedDescription);
        return;
    }
    
    DLog(@"Success");
    
}

- (void) locker:(id)locker didReceive:(NSError *)error {

    if (error) {
        DLog(@"%@", error.localizedDescription);
        return;
    }
    
    
    DLog(@"Success");

}


@end
