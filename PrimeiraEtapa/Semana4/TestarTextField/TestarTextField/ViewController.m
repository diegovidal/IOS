//
//  ViewController.m
//  TestarTextField
//
//  Created by bepid on 03/11/14.
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
    
    self.tfTeste.delegate = self;
    //[self.tfTeste becomeFirstResponder];
    
    self.tfTeste2.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //self.Label.text = [textField.text stringByAppendingString:string];
    if(self.tfTeste.isFirstResponder)
    {
        self.tfTeste2.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"tf1");
    }
    else if(self.tfTeste2.isFirstResponder)
    {
        self.tfTeste.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"tf2");
    }
   
    
    return YES; 
}



- (IBAction)stpEscolher:(UISegmentedControl *)sender {
    NSInteger index = [sender selectedSegmentIndex];
    if(index == 0){
        self.tfTeste.selected = YES;
        self.tfTeste2.selected = NO;
    }
    else
    {
        self.tfTeste.selected = NO;
        self.tfTeste2.selected = YES;
    }
}
@end
