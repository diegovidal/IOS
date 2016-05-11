//
//  ProdutosDatabase.h
//  Loja
//
//  Created by bepid on 12/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produto.h"

@interface ProdutosDatabase : NSObject

+ (void) initWithDefaultProdutos;
+ (NSMutableArray*) getProdutos;
+ (Produto*) getProdutoWithNome:(NSString*)nome;
+ (int) findProduct:(NSString*)produto;

@end
