//
//  Produto.h
//  lojaVirtual
//
//  Created by Usuário Convidado on 11/11/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Produto : NSObject

@property NSString *nome;
@property NSNumber *valor;
@property UIImage *imagem;
@property NSInteger quantidade;

- (instancetype)initWithNome:(NSString*)nome
                       valor:(NSNumber*)valor
                      imagem:(UIImage*)image;

@end
