//
//  ViewController.m
//  Contador
//
//  Created by bepid on 31/10/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.stepper1.value = 20;
    self.stepper2.value = 20;
    [self.num1 setText:@"20"];
    [self.num2 setText:@"20"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickStepper1:(UIStepper *)sender {
    
    [self.num1 setText:[NSString stringWithFormat:@"%2.f",[sender value] ]];
}

- (IBAction)clickStepper2:(UIStepper *)sender
{
    [self.num2 setText:[NSString stringWithFormat:@"%2.f",[sender value] ]];
}

- (IBAction)btnResetar:(UIButton *)sender
{
    self.stepper1.value = 20;
    self.stepper2.value = 20;
    [self.num1 setText:@"20"];
    [self.num2 setText:@"20"];
}

- (IBAction)alterarTela:(UIButton *)sender {
    
}
@end
