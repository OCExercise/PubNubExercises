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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.console scrollRangeToVisible:NSMakeRange([self.console.text length], 0)];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) locker:(id)locker didConnect:(NSError *)error {
    if (error) {
        DLog(@"%@", error.localizedDescription);
        [self logText:error.localizedDescription];
        return;
    }
    
    [self logText:[locker message]];
    
}

- (void) locker:(id)locker didReceive:(NSError *)error {
    
    if (error) {
        DLog(@"%@", error.localizedDescription);
        [self logText:error.localizedDescription];
        return;
    }
    
    [self logText:[locker message]];
    
}

- (void)logText:(NSString *)text
// Logs the specified text to the text view.
{
    // any thread
    assert(text != nil);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // Smart Scrolling
        [[_console textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:text]];
        
        [_console scrollRangeToVisible:NSMakeRange([_console.text length], 0)];
        
    }];
}



@end
