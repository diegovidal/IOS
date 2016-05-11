//
//  Produto.m
//  lojaVirtual
//
//  Created by Usuário Convidado on 11/11/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

#import "Produto.h"

@implementation Produto

- (instancetype)initWithNome:(NSString*)nome
                       valor:(NSNumber*)valor
                      imagem:(UIImage*)image
{
    self = [super init];
    if (self) {
        self.nome = nome;
        self.valor = valor;
        self.imagem = image;
    }
    return self;
}

@end
