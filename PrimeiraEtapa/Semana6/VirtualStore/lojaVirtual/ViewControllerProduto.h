//
//  ViewControllerProduto.h
//  lojaVirtual
//
//  Created by BEPiD on 11/12/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produto.h"
#import "Loja.h"
#import "ViewController.h"

@interface ViewControllerProduto : UIViewController <UITextFieldDelegate>

@property Produto *produto;
@property ViewController *telaPai;

@property (weak, nonatomic) IBOutlet UILabel *lpreco;
@property (weak, nonatomic) IBOutlet UILabel *lnome;
@property (weak, nonatomic) IBOutlet UITextField *txtQnt;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduto;

- (IBAction)btVoltar:(UIButton *)sender;
- (IBAction)btComprar:(UIButton *)sender;
@end
