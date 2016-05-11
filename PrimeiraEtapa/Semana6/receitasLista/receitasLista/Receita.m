//
//  Receita.m
//  receitasLista
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Receita.h"

@implementation Receita

-(id)initWithNome: (NSString*) nomeR Img: (NSString*) imgR Desc: (NSString*) descR Categ: (NSString*) categR
{
    self = [super init];
    if (self) {
        _nome = nomeR;
        _img = [UIImage imageNamed:imgR];
        _desc = descR;
        _categoria = categR;
    }
    return self;
}


@end
