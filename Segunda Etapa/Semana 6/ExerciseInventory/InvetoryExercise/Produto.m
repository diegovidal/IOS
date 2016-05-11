//
//  Produto.m
//  InvetoryExercise
//
//  Created by Diego Vidal on 19/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "Produto.h"

@implementation Produto

- (instancetype)initWithNome: (NSString*) nome andPreco:(NSString*) preco
{
    self = [super init];
    if (self) {
        _nome = nome;
        _preco = preco;
    }
    return self;
}

@end
