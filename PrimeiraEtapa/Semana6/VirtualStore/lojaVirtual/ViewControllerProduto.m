//
//  ViewControllerProduto.m
//  lojaVirtual
//
//  Created by BEPiD on 11/12/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerProduto.h"

@interface ViewControllerProduto ()

@end

@implementation ViewControllerProduto

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
    //[self.view endEditing:YES];
    _lnome.text = _produto.nome;
    _lpreco.text = [NSString stringWithFormat:@"R$ %@",_produto.valor];
    _imgProduto.image = _produto.imagem;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.txtQnt resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btVoltar:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btComprar:(UIButton *)sender {
  
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_txtQnt.text];
    
    if([myNumber integerValue]>0){
        _produto.quantidade = [myNumber integerValue];
        [_telaPai adicionarCarrinho:_produto];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else{
        
    }
}
@end
