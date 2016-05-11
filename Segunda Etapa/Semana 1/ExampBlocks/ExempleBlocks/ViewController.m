//
//  ViewController.m
//  ExempleBlocks
//
//  Created by Diego Vidal on 14/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftSlide:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:2. delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        //self.slideView.center = CGPointMake(300.f, 100.f);
        self.slideView.frame = CGRectMake(0.f, 60.f, 250, 620);
    } completion:^(BOOL finished) {
        NSLog(@"Terminou!");
    }];
}


- (IBAction)fazAlerta:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerta" message:@"Clique em algum dos botões"  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Botão 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Clicou no botão 1");
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Botão 2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Clicou no botão 2");
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
