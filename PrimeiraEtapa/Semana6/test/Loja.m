//
//  Loja.m
//  lojaVirtual
//
//  Created by Usuário Convidado on 11/11/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

#import "Loja.h"

@implementation Loja{
    @private
    NSMutableArray *produtos;
    NSMutableArray *carrinho;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        produtos = [NSMutableArray new];
        carrinho = [NSMutableArray new];
        [self populaProdutos];
    }
    return self;
}

-(void) addProdutoCarrinho:(Produto*)produto{
    [carrinho addObject:produto];
}
-(void) removerProdutoCarrinho:(Produto*)produto{
    [carrinho removeObject:produto];
}

-(Produto*) obterProduto:(NSString*) nome{
    for (Produto *p in produtos) {
        if([p.nome isEqualToString:nome]){
            return p;
        }
    }
    return nil;
}

-(void) addProdutoLoja:(Produto*)produto{
    [produtos addObject:produto];
}

-(void) removerProdutoLoja:(Produto*)produto{
    [produtos removeObject:produto];
}

-(void)populaProdutos{
    [produtos addObject:[[Produto alloc] initWithNome:@"Notebook" valor:@(1500.0) imagem:[UIImage imageNamed:@"notebook.jpg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Smartphone" valor:@(1000.0) imagem:[UIImage imageNamed:@"smartphone.jpg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Teclado" valor:@(100.0) imagem:[UIImage imageNamed:@"teclado.jpg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"PlayStation 4" valor:@(3500.0) imagem:[UIImage imageNamed:@"playstation.jpeg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Mouse" valor:@(50.0) imagem:[UIImage imageNamed:@"mouse.jpeg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Xbox" valor:@(2000.0) imagem:[UIImage imageNamed:@"xbox.jpg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Macbook" valor:@(10000.0) imagem:[UIImage imageNamed:@"macbook.jpeg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Ipod" valor:@(1000.0) imagem:[UIImage imageNamed:@"ipod.jpg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Ipad" valor:@(1200.0) imagem:[UIImage imageNamed:@"ipad.jpg"]]];
    [produtos addObject:[[Produto alloc] initWithNome:@"Iphone" valor:@(2000.0) imagem:[UIImage imageNamed:@"iphone.jpeg"]]];
}

-(NSInteger)countCarrinho{
    return carrinho.count;
}

-(NSInteger)countProdutos{
    return produtos.count;
}

-(Produto *)produtoAtIndex:(NSInteger)indice{
    return [produtos objectAtIndex:indice];
}

-(Produto *)carrinhoAtIndex:(NSInteger)indice{
    return [carrinho objectAtIndex:indice];
}

@end
