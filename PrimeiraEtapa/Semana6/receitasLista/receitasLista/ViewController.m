//
//  ViewController.m
//  receitasLista
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "Receita.h"
#import "ReceitaViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
@private NSMutableArray* listaReceitas;
@private NSArray* categorias;
    
@private Receita* receitaSelecionada;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Init Categ
    categorias = @[@"Sopas", @"Saladas", @"Massas", @"Peixe"];
    
    // Init Receita
    listaReceitas = [NSMutableArray new];

    
    [listaReceitas addObject:[[Receita alloc] initWithNome:@"Legumes ao forno" Img:@"receita1.jpg" Desc:@"Cozinhe todos os legumes, menos a batata" Categ:[categorias objectAtIndex:0]]];
    [listaReceitas addObject:[[Receita alloc] initWithNome:@"Tutu à mineira" Img:@"receita2.jpg" Desc:@"Taca arroz e ovo" Categ:[categorias objectAtIndex:0]]];
    [listaReceitas addObject:[[Receita alloc] initWithNome:@"Receita 3" Img:@"receita3.jpg" Desc:@"Taca arroz e ovo" Categ:[categorias objectAtIndex:1]]];
    [listaReceitas addObject:[[Receita alloc] initWithNome:@"Receita 4" Img:@"receita4.jpg" Desc:@"Taca arroz e ovo" Categ:[categorias objectAtIndex:1]]];
    [listaReceitas addObject:[[Receita alloc] initWithNome:@"Receita 5" Img:@"receita5.jpg" Desc:@"Taca arroz e ovo" Categ:[categorias objectAtIndex:2]]];
    [listaReceitas addObject:[[Receita alloc] initWithNome:@"Arroz com ovo" Img:@"receita6.jpeg" Desc:@"Taca arroz e ovo" Categ:[categorias objectAtIndex:3]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self receitasBy:[categorias objectAtIndex:section]].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"Receita";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    Receita *receita =  [[self receitasBy:[categorias objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.text = receita.nome;
    cell.detailTextLabel.text = receita.desc;
    
    
    cell.imageView.image = receita.img;
    
    CGSize itemSize = CGSizeMake(40, 35);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [categorias count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [categorias objectAtIndex:section];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    receitaSelecionada = [listaReceitas objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showReceita" sender:nil];
}

#pragma mark navegation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showReceita"]){
        ReceitaViewController *proximaTela = segue.destinationViewController;
        proximaTela.receitaRecebida = receitaSelecionada;
        
    }
}

-(NSMutableArray*) receitasBy:(NSString*)categoria{
    NSMutableArray *receitas = [NSMutableArray new];
    for (Receita *r in listaReceitas) {
        if([r.categoria isEqualToString:categoria]){
            [receitas addObject:r];
        }
    }
    return receitas;
}

@end
