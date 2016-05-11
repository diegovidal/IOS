//
//  DetailsViewController.m
//  SeiLaVei
//
//  Created by Diego Vidal on 02/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.mNome.text = self.nome;
    self.mTelefone.text = self.telefone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editarContato:(UIBarButtonItem *)sender {
    
    if([self.mButton.title isEqualToString:@"Edit"]){
        self.mNome.enabled = YES;
        self.mTelefone.enabled = YES;
    
        self.mButton.title = @"Done";
    }
    else{
        [self.coreDataHelper editarContatoComNome:self.nome eNumero:self.telefone eNomeNovo:self.mNome.text eNumeroNovo:self.mTelefone.text ];
        self.mNome.enabled = NO;
        self.mTelefone.enabled = NO;
        self.mButton.title = @"Edit";
    }
    
}
@end
