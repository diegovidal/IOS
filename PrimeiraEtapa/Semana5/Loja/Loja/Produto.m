//
//  Produto.m
//  Loja
//
//  Created by bepid on 12/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "Produto.h"

@implementation Produto

-(id)initWithNome:(NSString *)nome preco:(NSNumber *)preco foto:(NSString *)foto {
    self = [super init];
    if (self) {
        _nome = nome;
        _preco = preco;
        _foto = foto;
    }
    return self;
}

@end
