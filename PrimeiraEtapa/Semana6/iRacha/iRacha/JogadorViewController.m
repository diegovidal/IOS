//
//  JogadorViewController.m
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "JogadorViewController.h"

@interface JogadorViewController ()

@end

@implementation JogadorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mNome.delegate = self;
    self.mNumero.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    return [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btAdd:(UIBarButtonItem *)sender {
    NSString * nome = _mNome.text;
    NSNumber * numero = @([_mNumero.text integerValue] );
    [self.delegate addJogador:[[Jogador alloc]initWithNome: nome andNumero:(NSNumber*) numero]];

}
@end
