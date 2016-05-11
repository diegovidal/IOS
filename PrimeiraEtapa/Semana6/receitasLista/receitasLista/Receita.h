//
//  Receita.h
//  receitasLista
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receita : NSObject

@property(nonatomic) NSString *nome;
@property(nonatomic) UIImage *img;
@property(nonatomic) NSString *desc;
@property(nonatomic) NSString *categoria;

-(id)initWithNome: (NSString*) nomeR
              Img: (NSString*) imgR
             Desc: (NSString*) descR
            Categ: (NSString*) categR;

@end
