//
//  Pessoa.h
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pessoa : NSObject

@property(nonatomic) NSString* nome;
@property(nonatomic) NSString* telefone;
@property(nonatomic) UIImage* imagem;
@property (nonatomic) NSString* desc;


-(id)initWithNome: (NSString*) nomeR andTelefone:(NSString*) telR andImagem:(NSString*) imgR andDescricao: (NSString*) descR;

@end
