//
//  Jogador.h
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jogador : NSObject

@property (nonatomic)NSString* nome;
@property NSNumber* numGols;
@property NSNumber* numJogador;

-(id)initWithNome: (NSString *) nomeR andNumero:(NSNumber*) numJ;

@end
