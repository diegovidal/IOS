//
//  Jogador.m
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Jogador.h"

@implementation Jogador

-(id)initWithNome: (NSString *) nomeR andNumero:(NSNumber*) numJ{

    self = [super init];
    if (self) {
        _nome = nomeR;
        _numJogador = numJ;
        _numGols = 0;
    }
    return self;
}

@end
