//
//  ViewController.h
//  WebTeste
//
//  Created by Diego Vidal on 20/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *phone;

- (IBAction)adicionarContato:(UIButton *)sender;
- (IBAction)verContatos:(UIButton *)sender;
- (IBAction)gerarJSON:(UIButton *)sender;
- (IBAction)obterCursos:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *mNumero;

- (IBAction)calcularFatorial:(UIButton *)sender;


@end

