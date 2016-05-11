//
//  ViewController.m
//  mudaTela2
//
//  Created by bepid on 10/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "ViewController.h"
#include "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _corSelecionada = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)escolheCor:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _corSelecionada = [UIColor redColor];
            break;
        case 1:
            _corSelecionada = [UIColor greenColor];
            break;
        case 2:
            _corSelecionada = [UIColor blueColor];
            break;
            
        default:
            break;
    }
}


- (IBAction)mudaTela:(UIButton *)sender {
    [self performSegueWithIdentifier:@"mudaTela2" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"mudaTela2"]){
        ViewController2 *proximaTela = segue.destinationViewController;
        proximaTela.corRecebida = _corSelecionada;
    
    }

}
@end
