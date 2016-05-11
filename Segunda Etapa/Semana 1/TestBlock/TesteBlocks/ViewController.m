//
//  ViewController.m
//  TesteBlocks
//
//  Created by Diego Vidal on 14/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

// Principal utilização é que pode passar um block como parâmetro em um método

@interface ViewController ()


@end

@implementation ViewController

int (^soma)(int, int) = ^(int a, int b){
    return a + b;

};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block int factor = 5;
    
    int(^newResult)(void) = ^(void){
        factor +=1;
        return factor *10;
    };
    
    NSLog(@"\n%d", soma(1,2));
    NSLog(@"\n%d", newResult());
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animar:(UIButton *)sender {
    [UIView animateWithDuration:2 delay:0 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseInOut animations:^{
        self.view1.center = CGPointMake(200.f, 200.f);
    } completion:^(BOOL finished) {
        NSLog(@"Terminou!");
    }];
}
@end
