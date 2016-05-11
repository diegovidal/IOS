//
//  ViewControllerCadastrar.m
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerCadastrar.h"
#import "Pessoa.h"
#import "ListaContatosController.h"

@interface ViewControllerCadastrar ()

@end

@implementation ViewControllerCadastrar {
@private Pessoa *pessoa;
}

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
    self.mDescricao.delegate = self;
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

- (IBAction)actionCadastrar:(UIButton *)sender {
    NSString * nome = _mNome.text;
    NSString * numero = _mNumero.text;
    NSString * descricao = _mDescricao.text;
    
    pessoa = [[Pessoa alloc] initWithNome:nome andTelefone:numero andImagem:@"img1.jpg"andDescricao:descricao];
    
    
    [_view1.listContatos addObject:pessoa];
    [_view1.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    ListaContatosController *proximaTela;
//    
//    //ListaContatosController *proximaTela = [self.storyboard instantiateViewControllerWithIdentifier:@"MinhaTableView"];
//    
//    if ([segue.identifier isEqualToString:@"SegueCadastrarVolta"]) {
//        proximaTela = segue.destinationViewController;
//        [proximaTela.listContatos addObject:pessoa];
//        [proximaTela.tableView reloadData];
//    }
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];

}

@end
