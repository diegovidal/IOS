//
//  WebViewController.h
//  WebTeste
//
//  Created by Diego Vidal on 20/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface WebViewController : ViewController

- (IBAction)fechar:(UIButton *)sender;
- (IBAction)voltar:(UIButton *)sender;
- (IBAction)forward:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIWebView *navegador;
@end
