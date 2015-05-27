//
//  ViewController.m
//  MessengerMobile
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton * send;
@property (nonatomic, weak) IBOutlet UITextView * console;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate * delegate = (AppDelegate * )[[UIApplication sharedApplication] delegate];
    
    delegate.locker.delegate = self;
    [delegate.locker connect];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
