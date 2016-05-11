//
//  JogadorViewControllerDelegate.h
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jogador.h"

@protocol JogadorViewControllerDelegate <NSObject>

-(void)addJogador:(Jogador*) jogador;


@end
