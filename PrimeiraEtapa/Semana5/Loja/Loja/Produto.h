//
//  Produto.h
//  Loja
//
//  Created by bepid on 12/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Produto : NSObject

@property (nonatomic) NSString *nome;
@property (nonatomic) NSNumber *preco;
@property (nonatomic) NSString *foto;

- initWithNome:(NSString*)nome preco:(NSNumber*)preco foto:(NSString*)foto;

@end
