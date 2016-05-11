//
//  Pessoa.m
//  GaleriaFotos - Manhã
//
//  Created by bepid on 25/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Pessoa.h"

@implementation Pessoa

- (instancetype)initWihtImagem:(NSString *)newImagem andDescricao:(NSString *)newDescricao andData:(NSDate *)newData
    {
        self = [super init];
        if (self) {
            _imagem = [UIImage imageNamed:newImagem];
            _descricao = newDescricao;
            _data = newData;
        }
        return self;
    }
@end