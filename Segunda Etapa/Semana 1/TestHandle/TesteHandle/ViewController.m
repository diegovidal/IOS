//
//  ViewController.m
//  TesteHandle
//
//  Created by Diego Vidal on 14/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void)addNumber:(int)number1 withNumber:(int)number2 andCompletionHandler:(void (^) (int result)) completionHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNumber:4 withNumber:3 andCompletionHandler:^(int result) {
        NSLog(@"O resultado é %i", result);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNumber:(int)number1 withNumber:(int)number2 andCompletionHandler:(void (^)(int))completionHandler{
    int result = number1 + number2;
    completionHandler(result);

}

@end
