//
//  CoreDataHelper.m
//  SeiLaVei
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "CoreDataHelper.h"
#import "Contato.h"

@implementation CoreDataHelper

- (id)initWithContext: (NSManagedObjectContext*)context
{
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

-(NSArray *)pegaContatos{
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Contato" inManagedObjectContext:self.context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityDescription];
    
    Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.context];
    
    NSError *error;
    NSArray *respContatos = [self.context executeFetchRequest:request error:&error];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nome == %@ AND fone == %@", contato.nome, contato.fone];
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    
    NSLog(@"Lista de Contatos: %@", respContatos);
    return respContatos;
    
}

-(BOOL) adicionarContatoComNome:(NSString*)nome eNumero:(NSString*)numero{
    Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.context];
    
    contato.nome = nome;
    contato.fone = numero;
    
    NSError *error;
    
    return [self.context save:&error];

}

-(BOOL) editarContatoComNome:(NSString*) nome
                     eNumero:(NSString*) numero
                    eNomeNovo:(NSString*) nomeNovo
                  eNumeroNovo:(NSString*) numeroNovo{
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Contato" inManagedObjectContext:self.context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nome == %@ AND fone == %@", nome, numero];
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    
    Contato *c = [array firstObject];
    c.nome = nomeNovo;
    c.fone = numeroNovo;
    
    return [self.context save:&error];
}

-(BOOL) deletarContatoComNome:(NSString*) nome eNumero:(NSString*) numero{

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Contato" inManagedObjectContext:self.context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nome == %@ AND fone == %@", nome, numero];
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    
    Contato *c = [array firstObject];
    [self.context deleteObject:c];
    return [self.context save:&error];
}


@end
