//
//  ShowDetailsController.h
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pessoa.h"
#import "ListaContatosController.h"

@interface ShowDetailsController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mNome;
@property (weak, nonatomic) IBOutlet UILabel *mTelefone;
@property (weak, nonatomic) IBOutlet UIImageView *mImagem;
@property (weak, nonatomic) IBOutlet UITextView *mDescricao;
@property (nonatomic) ListaContatosController* tabelaContatos;

@property(nonatomic) Pessoa* pessoaRecebida;

@end
