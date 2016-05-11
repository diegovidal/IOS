//
//  ReceitaViewController.m
//  receitasLista
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ReceitaViewController.h"

@interface ReceitaViewController ()

@end

@implementation ReceitaViewController

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
    self.mNome.text = self.receitaRecebida.nome;
    self.mImagem.image = self.receitaRecebida.img;
    self.mDesc.text = self.receitaRecebida.desc;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
