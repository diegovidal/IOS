//
//  IBGesturesViewController.m
//  Gestures - Tap e Long Press
//
//  Created by Jagni Dasa Horta Bezerra on 25/01/15.
//  Copyright (c) 2015 Jagni Dasa Horta Bezerra. All rights reserved.
//

#import "IBGesturesViewController.h"

@interface IBGesturesViewController ()

@property (nonatomic) int numTaps;

@end

@implementation IBGesturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _numTaps = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)tap:(id)sender {
    _numTaps++;
    _numberTaps.text = [NSString stringWithFormat:@"%i Taps", _numTaps];
    
}

- (IBAction)longPress:(UIGestureRecognizer*)sender {
    
    if(sender.state == UIGestureRecognizerStateEnded){
    _numTaps--;
    _numberTaps.text = [NSString stringWithFormat:@"%i Taps", _numTaps];
    }
}
@end
