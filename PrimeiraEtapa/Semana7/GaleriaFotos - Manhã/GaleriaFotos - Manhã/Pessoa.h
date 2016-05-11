//
//  Pessoa.h
//  GaleriaFotos - Manhã
//
//  Created by bepid on 25/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pessoa : NSObject
@property UIImage *imagem;
@property NSString *descricao;
@property NSDate *data;

- (instancetype)initWihtImagem:(NSString *)newImagem andDescricao:(NSString *)newDescricao andData:(NSDate *)newData;
@end