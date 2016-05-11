//
//  ViewController.m
//  lojaVirtual
//
//  Created by Usuário Convidado on 11/11/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerProduto.h"

@interface ViewController ()

@end

@implementation ViewController{
    @private
    Loja *loja;
    Produto *produtoTemp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	loja = [Loja new];
    self.tableViewCarrinho.dataSource = self;
    self.tableViewCarrinho.delegate = self;
    self.tableViewProdutos.delegate = self;
    self.tableViewProdutos.dataSource = self;

    
    [ _tableViewCarrinho setTag:99];
    [ _tableViewProdutos setTag:88];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 99)
        return [loja countCarrinho];
    else
        return [loja countProdutos];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Produto";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(tableView.tag ==99){
        Produto *p = [loja carrinhoAtIndex:indexPath.row];
        imgView.image = p.imagem;
        cell.imageView.image = imgView.image;
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld x %@", (long)p.quantidade,p.nome];    }
    
    else{
        Produto *p = [loja produtoAtIndex:indexPath.row];
        imgView.image = p.imagem;
        cell.imageView.image = imgView.image;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", p.nome];
    }
    return cell;
}

- (void)refresh:(NSNotification *)notification
{
    [self.tableViewCarrinho reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    produtoTemp=[loja obterProduto:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [self performSegueWithIdentifier:@"irTela02" sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}



#pragma mark navegation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"irTela02"]){
        ViewControllerProduto *proximaTela = segue.destinationViewController;
        proximaTela.produto = produtoTemp;
        proximaTela.telaPai = self;
    }
}

-(void)adicionarCarrinho:(Produto*)produto{
    [loja addProdutoCarrinho:produto];
    [_tableViewCarrinho reloadData];
}


- (IBAction)btAddProduto:(UIButton *)sender {
}
@end
