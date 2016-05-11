//
//  GesturesViewController.m
//  Gestures - Tap e Long Press
//
//  Created by Jagni Dasa Horta Bezerra on 25/01/15.
//  Copyright (c) 2015 Jagni Dasa Horta Bezerra. All rights reserved.
//

#import "GesturesViewController.h"

@interface GesturesViewController ()

@end

@implementation GesturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *recognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    recognize.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:recognize];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tap: (UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}

@end
