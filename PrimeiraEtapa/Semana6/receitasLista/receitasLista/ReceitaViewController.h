//
//  ReceitaViewController.h
//  receitasLista
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receita.h"

@interface ReceitaViewController : UIViewController


@property (nonatomic) Receita* receitaRecebida;

@property (weak, nonatomic) IBOutlet UILabel *mNome;
@property (weak, nonatomic) IBOutlet UIImageView *mImagem;
@property (weak, nonatomic) IBOutlet UITextView *mDesc;

@end
