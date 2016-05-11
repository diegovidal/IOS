//
//  ViewController.m
//  listContato
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
@private NSMutableArray *contatos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.dataSource = self;
    self.tableView.delegate = self;
    contatos = [NSMutableArray new];
//    [contatos addObject:[[Contato alloc] initWithNome:@"Diego Vidal" telefone:@"(85) 8585-1091"]];
//    [contatos addObject:[[Contato alloc] initWithNome:@"Andre Wescley" telefone:@"(85) 8752-5137"]];
//    [contatos addObject:[[Contato alloc] initWithNome:@"Edivando Alves" telefone:@"(85) 8922-7247"]];
//    [contatos addObject:[[Contato alloc] initWithNome:@"Dorgival Dantas" telefone:@"(85) 8585-1091"]];
//    [contatos addObject:[[Contato alloc] initWithNome:@"Tomás Turbando" telefone:@"(85) 8752-5137"]];
//    [contatos addObject:[[Contato alloc] initWithNome:@"Severina ChikChik" telefone:@"(85) 8922-7247"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contatos count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"Contato";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    Contato *contato = [contatos objectAtIndex:indexPath.row];
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.telefone;
    
    
    cell.imageView.image = [UIImage imageNamed:@"sarney.jpg"];
    
    CGSize itemSize = CGSizeMake(40, 35);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contato *contato = [contatos objectAtIndex:indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contato" message:[NSString stringWithFormat:@"Nome: %@ \nTelefone: %@", contato.nome, contato.telefone] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [contatos removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Excluir";
}


- (IBAction)btnEditar:(UIButton *)sender {
    if([self.editar.titleLabel.text isEqualToString:@"Editar"]){
        [self.tableView setEditing:YES animated:YES];
        [self.editar setTitle:@"Pronto" forState:UIControlStateNormal];
    }else{
        [self.tableView setEditing:NO animated:YES];
        [self.editar setTitle:@"Editar" forState:UIControlStateNormal];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

@end
