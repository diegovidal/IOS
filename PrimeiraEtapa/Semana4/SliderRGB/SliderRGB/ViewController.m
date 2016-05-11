//
//  ViewController.m
//  SliderRGB
//
//  Created by bepid on 04/11/14.
//  Copyright (c) 2014 ifce. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.r = 1.0;
    self.b = 1.0;
    self.g = 1.0;
    //[self mudaCor];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SliderRed:(UISlider *)sender {
    self.r = sender.value;
    _redField.backgroundColor = [UIColor colorWithRed:self.r green:0.0 blue:0.0 alpha:1.0];
    _redField.text = [NSString stringWithFormat:@"%2.f", [sender value]*255 ] ;
    [self mudaCor];
}

- (IBAction)SliderGreen:(UISlider *)sender {
    self.g = sender.value;
    _greenField.backgroundColor = [UIColor colorWithRed:0.0 green:self.g blue:0.0 alpha:1.0];
    _greenField.text = [NSString stringWithFormat:@"%2.f", [sender value]*255 ] ;
    [self mudaCor];
}


- (IBAction)SliderBlue:(UISlider *)sender {
    self.b = sender.value;
    _blueField.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:self.b alpha:1.0];
    _blueField.text = [NSString stringWithFormat:@"%2.f", [sender value]*255 ] ;
    [self mudaCor];
}



-(void) mudaCor
{
    self.view.BackgroundColor =[UIColor colorWithRed:self.r green:self.g blue:self.b alpha:1.0];
}


@end
