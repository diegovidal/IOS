//
//  ViewController.h
//  Contador
//
//  Created by bepid on 31/10/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *num1;
@property (weak, nonatomic) IBOutlet UILabel *num2;

@property (weak, nonatomic) IBOutlet UIStepper *stepper1;

@property (weak, nonatomic) IBOutlet UIStepper *stepper2;

@property (weak, nonatomic) IBOutlet UIButton *btAlterarTela;


- (IBAction)clickStepper1:(UIStepper *)sender;
- (IBAction)clickStepper2:(UIStepper *)sender;
- (IBAction)btnResetar:(UIButton *)sender;
- (IBAction)alterarTela:(UIButton *)sender;



@end
