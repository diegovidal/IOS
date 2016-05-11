//
//  Contato.h
//  listContato
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject

@property NSString *nome;
@property NSString *telefone;
@property UIImage *image;

- (instancetype)initWithNome:(NSString*)nome
                    telefone:(NSString*)telefone;

- (instancetype)initWithNome:(NSString*)nome
                    telefone:(NSString*)telefone
                       image:(UIImage*)image;


@end
