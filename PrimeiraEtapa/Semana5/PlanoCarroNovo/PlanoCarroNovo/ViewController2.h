//
//  ViewController2.h
//  PlanoCarroNovo
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imagemCarro;
@property (weak, nonatomic) IBOutlet UILabel *nomeCarro;
@property (weak, nonatomic) UIImage *imagemRecebida;

@property (nonatomic) NSString *carroRecebido;


@end
