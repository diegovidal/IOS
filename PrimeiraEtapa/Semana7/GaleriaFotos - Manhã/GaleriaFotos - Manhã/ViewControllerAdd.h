//
//  ViewControllerAdd.h
//  GaleriaFotos - Manhã
//
//  Created by bepid on 25/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Pessoa.h"

@interface ViewControllerAdd : UIViewController <UITextViewDelegate>

@property ViewController * viewUm;

- (IBAction)btnDone:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textDate;
@property (weak, nonatomic) IBOutlet UITextView *textDescricao;
@property (weak, nonatomic) IBOutlet UIImageView *imageAdd;

- (IBAction)datePicker:(UIDatePicker *)sender;
- (IBAction)cadastroBack:(UIBarButtonItem *)sender;

@end
