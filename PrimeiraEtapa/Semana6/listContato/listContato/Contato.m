//
//  Contato.m
//  listContato
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Contato.h"

@implementation Contato


- (instancetype)initWithNome:(NSString*)nome
                    telefone:(NSString*)telefone
{
    self = [super init];
    if (self) {
        self.nome = nome;
        self.telefone = telefone;
    }
    return self;
}

- (instancetype)initWithNome:(NSString*)nome
                    telefone:(NSString*)telefone
                       image:(UIImage*)image{
    self = [super init];
    if (self) {
        self.nome = nome;
        self.telefone = telefone;
        self.image = image;
    }
    return self;
}
@end
