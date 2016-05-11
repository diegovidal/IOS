//
//  ProdutosViewController.m
//  Loja
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "ProdutosViewController.h"
#import "ProdutosDatabase.h"
#import "AdicionarViewController.h"

@interface ProdutosViewController ()

@end

@implementation ProdutosViewController

static Produto* produto;
static NSMutableArray* tableData;

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
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [ProdutosDatabase initWithDefaultProdutos];
    
    tableData = [NSMutableArray new];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTouchButtonAdicionar:(id)sender {
    UIAlertView *adicionarAlertView = [[UIAlertView alloc] initWithTitle:@"Adicionar" message:@"Insira o nome do produto" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Adicionar", nil];
    adicionarAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [adicionarAlertView show];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AdicionarViewController* view = segue.destinationViewController;
    view.produto = produto;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // Se clicou em "Adicionar", vai checar se o produto existe
    if (buttonIndex == 0) {
        // Clicou em "Cancelar"
        return;
    }
    
    // Procura o produto
    NSString* nomeProduto = [alertView textFieldAtIndex:0].text;
    produto = [ProdutosDatabase getProdutoWithNome:nomeProduto];
    if (produto != nil) {
        // Proxima tela
        [self performSegueWithIdentifier:@"adicionarProduto" sender:self];
        [tableData addObject:nomeProduto];
        [self.mTableView reloadData];
        return;
    }
    
    // Informar produto nao encontrado
    UIAlertView *alertViewNaoEncontrado = [[UIAlertView alloc] initWithTitle:@"Produto não encontrado" message:@"Cuidado com erros de digitação" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertViewNaoEncontrado show];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SimpleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

@end
