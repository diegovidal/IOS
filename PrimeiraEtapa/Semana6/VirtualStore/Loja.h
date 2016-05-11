//
//  Loja.h
//  lojaVirtual
//
//  Created by Usuário Convidado on 11/11/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produto.h"

@interface Loja : NSObject

-(void) addProdutoCarrinho:(Produto*)produto;
-(void) removerProdutoCarrinho:(Produto*)produto;
-(NSInteger) countCarrinho;
-(Produto*) carrinhoAtIndex:(NSInteger)indice;

-(Produto*) obterProduto:(NSString*) nome;

-(void) addProdutoLoja:(Produto*)produto;
-(void) removerProdutoLoja:(Produto*)produto;
-(NSInteger) countProdutos;
-(Produto*) produtoAtIndex:(NSInteger)indice;




@end
