//
//  ViewControllerCadastrar.h
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListaContatosController.h"

@interface ViewControllerCadastrar : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mNome;
@property (weak, nonatomic) IBOutlet UITextField *mNumero;
@property (weak, nonatomic) IBOutlet UITextField *mDescricao;
@property(nonatomic) ListaContatosController * view1;

- (IBAction)actionCadastrar:(UIButton *)sender;

@end
