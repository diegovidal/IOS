//
//  ViewController.m
//  listaCompras
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mTabela = [NSMutableArray new];
    self.mListaProdutos.delegate = self;
    self.mListaProdutos.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adicionarProduto:(UIButton *)sender {
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Preencha o seu produto" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    alerta.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alerta show];
}

#pragma marks - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mTabela count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *produto5 = @"teste";
    
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:produto5];
    
    if (celula == nil) {
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:produto5];
    }
    
    celula.textLabel.text = [self.mTabela objectAtIndex:indexPath.row];
    return celula;
}

#pragma marks - AlertView

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *produto = [alertView textFieldAtIndex:0];
    [self.mTabela addObject:produto.text];
    [self.mListaProdutos reloadData];
}


@end
