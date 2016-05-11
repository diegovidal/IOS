//
//  Pergunta.h
//  PageControlQuestions
//
//  Created by bepid on 18/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pergunta : NSObject

@property(nonatomic) NSString* pergunta;
@property(nonatomic) UIImage* img ;
@property(nonatomic) BOOL resposta;
@property (nonatomic) UISwitch *switchResp;

-(id)initWithPergunta: (NSString*) perguntaR andImage: (UIImage*) imgR andReposta: (BOOL) respostaR;

@end
