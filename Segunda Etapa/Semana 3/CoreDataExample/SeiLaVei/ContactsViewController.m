//
//  ContactsViewController.m
//  SeiLaVei
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ContactsViewController.h"
#import "CoreDataHelper.h"
#import "Contato.h"
#import "ViewController.h"
#import "DetailsViewController.h"

@interface ContactsViewController ()

@property (nonatomic) CoreDataHelper *coreDataHelper;
@property (nonatomic) NSArray *contatos;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreDataHelper = [[CoreDataHelper alloc] initWithContext:self.context];
    self.tableView.tableFooterView = [UIView new];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.contatos = [self.coreDataHelper pegaContatos];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.contatos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellContato" forIndexPath:indexPath];
    
    Contato *c = [self.contatos objectAtIndex:indexPath.row];
    cell.textLabel.text = c.nome;
    cell.detailTextLabel.text = c.fone ;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.coreDataHelper deletarContatoComNome:cell.textLabel.text eNumero:cell.detailTextLabel.text];
        self.contatos = [self.coreDataHelper pegaContatos];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
}


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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Contato *c = [self.contatos objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueDetails" sender:c];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)buttonAddContact:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"segueAdd" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueAdd"]){
        ViewController *viewcontroller = segue.destinationViewController;
        viewcontroller.coreDataHelper = self.coreDataHelper;
    }
    else if([segue.identifier isEqualToString:@"segueDetails"]){
        DetailsViewController *detailsViewController = segue.destinationViewController;
        detailsViewController.coreDataHelper = self.coreDataHelper;
        Contato *c = sender;
        detailsViewController.nome = c.nome;
        detailsViewController.telefone = c.fone;
    }
}


@end
