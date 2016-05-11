//
//  ViewController.m
//  GestureChallenge
//
//  Created by Diego Vidal on 09/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

UIPinchGestureRecognizer *pinchGesture;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Se ele reconhecer o tap ele não reconhece o doubleTap
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPan:)];
    [_quadrado addGestureRecognizer:panGesture];
    
    pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doPinch:)];
    [_quadrado addGestureRecognizer:pinchGesture];
    
    [_mPressTap requireGestureRecognizerToFail:panGesture];
    [_mTapFast requireGestureRecognizerToFail:_mDoubleTap];
    [_mPressTap requireGestureRecognizerToFail:pinchGesture];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) doPinch: (UIPinchGestureRecognizer*) sender{
    _quadrado.transform = CGAffineTransformScale(_quadrado.transform, pinchGesture.scale, pinchGesture.scale);
    
    pinchGesture.scale = 1.0;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) doPan:(UIPanGestureRecognizer*) sender{
    _quadrado.center = [sender locationInView:self.view];
}

- (IBAction)fastTap:(UITapGestureRecognizer *)sender {
    
    
    
//    [UIView animateKeyframesWithDuration:0.1 delay:0 options:UIViewAnimationCurveLinear animations:^{
//        _click.backgroundColor = [UIColor grayColor];
//        _click.center = [sender locationInView:self.view];
//    } completion:^(BOOL finished) {
//        _click.backgroundColor = [UIColor clearColor];
//    }];
    
    NSLog(@"Teste tap");
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        _quadrado.center = [sender locationInView:self.view];
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    
    
    
}

- (IBAction)doubleTap:(UITapGestureRecognizer *)sender {
    
//    [UIView animateKeyframesWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
//        _click.backgroundColor = [UIColor grayColor];
//        _click.center = [sender locationInView:self.view];
//    } completion:^(BOOL finished) {
//        _click.backgroundColor = [UIColor clearColor];
//    }];
    
    NSLog(@"Teste doubleTap");
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        _quadrado.center = [sender locationInView:self.view];
    } completion:^(BOOL finished) {
        
    }];
    
   
}

- (IBAction)pressTap:(UILongPressGestureRecognizer *)sender {
    
    _quadrado.backgroundColor = [UIColor redColor];
}
@end
