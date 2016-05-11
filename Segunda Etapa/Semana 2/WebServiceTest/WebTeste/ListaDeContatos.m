//
//  ListaDeContatos.m
//  WebTeste
//
//  Created by Diego Vidal on 20/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ListaDeContatos.h"
#import "contatoCell.h"

@interface ListaDeContatos ()

@end

@implementation ListaDeContatos

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRequest];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _itemsContatos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"contatoCell";
    contatoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *contato = [[_itemsContatos objectAtIndex:indexPath.row] componentsSeparatedByString:@"&"];
    
    // Tive que tratar pois alguns dados do servidor estavam inválidos.
    if(contato.count == 2){
    cell.nomeContato.text = [[contato objectAtIndex:0] stringByReplacingOccurrencesOfString:@"NOME=" withString:@""];
     cell.nomeContato.text = [self decodeString:cell.nomeContato.text];
    
    cell.foneContato.text = [[contato objectAtIndex:1] stringByReplacingOccurrencesOfString:@"FONE=" withString:@""];
    cell.foneContato.text = [self decodeString:cell.foneContato.text];
    }
    
    
    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - WEB

- (void)getRequest {
    // Criando a requisição
    NSString *dados = @"http://www.ime.usp.br/~glauber/cgi-bin/BEPiD/verContatos";
    NSURL *url = [NSURL URLWithString:dados];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Enviando a requisicão
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *resposta = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    // Exibindo Resposta
    NSString *mensagem;
    if(resposta){
        mensagem = [[NSString alloc] initWithData:resposta encoding:NSUTF8StringEncoding];
        _itemsContatos = [mensagem componentsSeparatedByString:@"\n"];
    }
    else{
        mensagem = @"Deu pau!";
    }
    
    //self.nome.text = @"";
    //NSLog(@"%@", mensagem);
}

- (NSString*)decodeString:(NSString*)string
{
    NSString *decodedString = [string stringByRemovingPercentEncoding];
    NSLog(@"%@",decodedString);
    return decodedString;
}

@end
