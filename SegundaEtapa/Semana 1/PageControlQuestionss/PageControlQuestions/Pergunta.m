//
//  Pergunta.m
//  PageControlQuestions
//
//  Created by bepid on 18/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Pergunta.h"

@implementation Pergunta

-(id)initWithPergunta: (NSString*) perguntaR andImage: (UIImage*) imgR andReposta: (BOOL) respostaR
{
    self = [super init];
    if (self) {
        _pergunta = perguntaR;
        _img = imgR;
        _resposta = respostaR;
    }
    return self;
}

@end
