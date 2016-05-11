//
//  ViewController.m
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleImage:(id)sender {
    //_mImage.hidden = !_mImage.hidden;
    if (_mImage.image == nil) {
        _mImage.image = [UIImage imageNamed:@"ifce.jpg"];
    } else {
        _mImage.image = nil;
    }
}

@end
