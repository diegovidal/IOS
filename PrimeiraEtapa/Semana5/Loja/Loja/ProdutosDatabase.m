//
//  ProdutosDatabase.m
//  Loja
//
//  Created by bepid on 12/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "ProdutosDatabase.h"

@implementation ProdutosDatabase

static NSMutableArray *produtos;

+ (void) initWithDefaultProdutos {
    produtos = [NSMutableArray new];
    [produtos addObject:[[Produto alloc] initWithNome:@"Nescau" preco:@1.00 foto:@"foto_nescau"]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Biscoito" preco:@1.00 foto:@"foto_biscoito"]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Água" preco:@1.00 foto:@"foto_agua"]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Leite" preco:@1.00 foto:@"foto_leite"]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Ypioca" preco:@1.00 foto:@"foto_ypioca"]];}

+ (NSMutableArray*) getProdutos {
    return produtos;
}

+ (Produto*) getProdutoWithNome:(NSString*)nome {
    for (Produto* p in produtos) {
        if ([p.nome isEqualToString:nome]) {
            return p;
        }
    }
    return nil;
}

+ (int) findProduct:(NSString*)produto {
    return [produtos indexOfObject:produto];
}

@end
