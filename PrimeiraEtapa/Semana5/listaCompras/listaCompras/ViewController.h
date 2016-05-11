		//
//  ViewController.h
//  listaCompras
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mListaProdutos;
@property (weak, nonatomic) IBOutlet UILabel *valorTotal;

@property (nonatomic) NSMutableArray *mTabela;

- (IBAction)adicionarProduto:(UIButton *)sender;

@end
