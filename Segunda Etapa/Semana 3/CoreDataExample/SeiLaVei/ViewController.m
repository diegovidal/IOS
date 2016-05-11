//
//  ViewController.m
//  SeiLaVei
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adicionarContato:(UIBarButtonItem *)sender {
    
    if(![self.mNome.text isEqualToString:@""] && ![self.mTelefone.text isEqualToString:@""]){
        if([self.coreDataHelper adicionarContatoComNome:self.mNome.text eNumero:self.mTelefone.text]){
            [self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"Salvou com sucesso.");
        }
    
    }
}
@end
