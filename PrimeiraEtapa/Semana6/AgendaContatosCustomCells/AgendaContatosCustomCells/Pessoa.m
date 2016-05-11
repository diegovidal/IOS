//
//  Pessoa.m
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Pessoa.h"

@implementation Pessoa

-(id)initWithNome: (NSString*) nomeR andTelefone:(NSString*) telR andImagem:(NSString*) imgR andDescricao: (NSString*) descR
{
    self = [super init];
    if (self) {
        _nome = nomeR;
        _telefone = telR;
        _imagem = [UIImage imageNamed:imgR];
        _desc = descR;
    }
    return self;
}


@end
