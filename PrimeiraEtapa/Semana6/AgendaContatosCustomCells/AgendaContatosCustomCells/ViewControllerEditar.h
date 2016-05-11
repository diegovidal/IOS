//
//  ViewControllerEditar.h
//  AgendaContatosCustomCells
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerEditar : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mNomeEditar;
@property (weak, nonatomic) IBOutlet UITextField *mTelefoneEditar;
@property (weak, nonatomic) IBOutlet UITextField *mDescEditar;

- (IBAction)editarPessoa:(UIButton *)sender;

@end
