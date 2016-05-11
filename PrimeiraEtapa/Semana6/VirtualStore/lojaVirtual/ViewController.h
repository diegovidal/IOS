//
//  ViewController.h
//  lojaVirtual
//
//  Created by Usuário Convidado on 11/11/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loja.h"
#import "Produto.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(void)adicionarCarrinho:(Produto*)produto;

@property (weak, nonatomic) IBOutlet UITableView *tableViewCarrinho;
@property (weak, nonatomic) IBOutlet UITableView *tableViewProdutos;
- (IBAction)btAddProduto:(UIButton *)sender;

@end
