//
//  ListaContatosController.m
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ListaContatosController.h"
#import "Pessoa.h"
#import "PessoaCell.h"
#import "ShowDetailsController.h"
#import "ViewControllerCadastrar.h"

@interface ListaContatosController ()

@end

@implementation ListaContatosController
{
@private Pessoa* pessoaParaEnvio;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Intância dos Objetos Pessoa
    
    NSString* desc = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in";
    
    Pessoa* p1 = [[Pessoa alloc] initWithNome:@"Diego Vidal" andTelefone:@"85251091" andImagem:@"img1.jpg" andDescricao:desc];
    
    Pessoa* p2 = [[Pessoa alloc] initWithNome:@"Athyla Bezerra" andTelefone:@"99149603" andImagem:@"img1.jpg" andDescricao:desc];
    
    Pessoa* p3 = [[Pessoa alloc] initWithNome:@"Dorgival Dantas" andTelefone:@"85251091" andImagem:@"img1.jpg" andDescricao:desc];
    
    Pessoa* p4 = [[Pessoa alloc] initWithNome:@"Márcio de Paula" andTelefone:@"97379692" andImagem:@"img1.jpg" andDescricao:desc];
    
    Pessoa* p5 = [[Pessoa alloc] initWithNome:@"Zezo" andTelefone:@"85251091" andImagem:@"img1.jpg" andDescricao:desc];
    
    _listContatos = [[NSMutableArray alloc] initWithObjects:p1,p2,p3,p4,p5, nil];
    
    //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return _listContatos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PessoaCell";
    PessoaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [PessoaCell new];
    }
    
    Pessoa *pessoa = (self.listContatos)[indexPath.row];
    cell.mNome.text = pessoa.nome;
    cell.mTelefone.text = pessoa.telefone;
    cell.mImagem.image = pessoa.imagem;
    
    return cell; 
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Excluir";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_listContatos removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    pessoaParaEnvio = [_listContatos objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showDetails" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   // ShowDetailsController *proximaTela;
    
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        ShowDetailsController *proximaTela;
        proximaTela = segue.destinationViewController;
        proximaTela.pessoaRecebida = pessoaParaEnvio;
    }
    else if ([segue.identifier isEqualToString:@"SegueCadastrar"]) {
        ViewControllerCadastrar *proximaTela;
        proximaTela = segue.destinationViewController;
        proximaTela.view1 = self;
    }
    
}

@end
