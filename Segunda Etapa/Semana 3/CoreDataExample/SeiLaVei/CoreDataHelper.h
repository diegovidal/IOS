//
//  CoreDataHelper.h
//  SeiLaVei
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Coredata/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic) NSManagedObjectContext *context;

- (id)initWithContext: (NSManagedObjectContext*) context;
-(NSArray*) pegaContatos;

-(BOOL) adicionarContatoComNome:(NSString*)nome eNumero:(NSString*)numero;
-(BOOL) editarContatoComNome:(NSString*) nome
                     eNumero:(NSString*) numero
                   eNomeNovo:(NSString*) nomeNovo
                 eNumeroNovo:(NSString*) numeroNovo;
-(BOOL) deletarContatoComNome:(NSString*) nome eNumero:(NSString*) numero;

@end
