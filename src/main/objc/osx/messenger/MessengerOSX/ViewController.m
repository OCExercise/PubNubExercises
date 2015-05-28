//
//  ViewController.m
//  MessengerOSX
//
//  Created by Presley Cannady on 5/27/15.
//  Copyright (c) 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property (unsafe_unretained) IBOutlet NSTextView * console;

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
        BOOL scroll = (NSMaxY(self.console.visibleRect) == NSMaxY(self.console.bounds));

        [[_console textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:text]];
        
        if (scroll) // Scroll to end of the textview contents
            [self.console scrollRangeToVisible: NSMakeRange(self.console.string.length, 0)];

    }];
}



@end
