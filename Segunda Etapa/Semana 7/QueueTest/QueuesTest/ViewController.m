//
//  ViewController.m
//  QueuesTest
//
//  Created by Diego Vidal on 25/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Preparing to run code in secondary thread...");
    //dispatch_queue_t myQueue = dispatch_queue_create("My Queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myQueue, ^{
        NSLog(@"Running code in secondary thread...");
        int value = 0;
        for (int i=0; i<100; i++) {
            for (int j=0; j<100; j++) {
                for (int n=0; n<100; n++) {
                    value += j;
                }
            }
        }
        NSLog(@"From secondary thread: value = %d", value);
    });
//    dispatch_async(myQueue, ^{
//        NSLog(@"3rd Thread...");
//        for (int k=0; k<5; k++) {
//            for (int y=0; y<250000; y++) {}
//            NSLog(@"%d\n", k);
//        }
//        NSLog(@"3rd Thread finished");
//    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSLog(@"3rd Thread...");
        for (int k=0; k<5; k++) {
            for (int y=0; y<250000; y++) { }
            NSLog(@"%d\n", k);
        }
        NSLog(@"3rd Thread finished");
    });
    NSLog(@"This is main thread again...");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
