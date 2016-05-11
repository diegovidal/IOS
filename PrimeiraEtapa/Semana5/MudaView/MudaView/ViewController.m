//
//  ViewController.m
//  MudaView
//
//  Created by bepid on 10/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

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

- (IBAction)mButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"irTela2" sender:sender];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"irTela2"]){
        ViewController2 *view2 = segue.destinationViewController;
        view2.textoRecebido = [NSString stringWithFormat:@"O texto é %@", _mTextField.text];
    }
}


@end
