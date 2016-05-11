//
//  ViewController.m
//  AlertViewExample
//
//  Created by bepid on 10/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
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



- (IBAction)mostraAlerta:(UIButton *)sender {
    UIAlertView *alerta;
    switch (sender.tag) {
        case 0:
            alerta = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Digite seu nome" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            alerta.alertViewStyle = UIAlertViewStylePlainTextInput;

            [alerta show];
            break;
        case 1:
            alerta = [[UIAlertView alloc] initWithTitle:@"Senha" message:@"Digite sua senha" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            alerta.alertViewStyle = UIAlertViewStyleSecureTextInput;
            alerta.tag = 1;
            [alerta show];
            break;
        default:
            break;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 0:
        {
            switch (buttonIndex) {
                case 1:
                {
                    UITextField* texto = [alertView textFieldAtIndex:0];
                    NSLog(@"%@", texto.text);
                    break;
                }
                default:
                    break;
            }
        break;
        }
        case 1:
        {
            if (buttonIndex == 1) {
                UITextField* texto = [alertView textFieldAtIndex:0];
                NSLog(@"%@", texto.text);
            }
        }
            break;
        default:
            break;
    }
}
@end
