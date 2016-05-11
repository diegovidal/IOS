//
//  SecondViewController.m
//  GestureTest2
//
//  Created by Diego Vidal on 11/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "PanView.h"

@interface PanView ()

@end

@implementation PanView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIPanGestureRecognizer *panRecognize = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.quadrado addGestureRecognizer:panRecognize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)panGesture:(UIPanGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:self.view];
    self.quadrado.center = point;
    
    CGPoint vel = [gesture velocityInView:self.view];
    self.vHorizontal.text = [NSString stringWithFormat:@"%.2f p/s", vel.x];
    self.vVertical.text = [NSString stringWithFormat:@"%.2f p/s", vel.y];
}

@end
