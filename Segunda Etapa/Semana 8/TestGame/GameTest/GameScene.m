//
//  GameScene.m
//  GameTest
//
//  Created by Diego Vidal on 02/03/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    //myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        CGFloat xi = 30;
//        CGFloat yi = self.view.frame.size.height + 60;
//        CGFloat xf = self.view.frame.size.width + 400;
        
        CGFloat yi = self.frame.size.height/2;
        CGFloat xf = self.frame.size.width -135;
        //NSLog(@"height: %f width: %f", self.size.height, self.size.width);
        
        CGFloat xf2 = self.frame.size.width + 30 ;
        sprite.position = CGPointMake(xi, yi);
        
        [sprite setScale:0.4];
//        sprite.position = location;
//        
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        //[sprite runAction:[SKAction repeatActionForever:action]];
        
//        SKAction *diminuir = [SKAction scaleBy:0.3 duration:1.0];
//        [sprite runAction:diminuir];
        
        SKAction *rotateByDireita90 = [SKAction rotateByAngle:-M_PI/2.0 duration:0.5];
//        SKAction *rotateByDireita902 = [SKAction rotateByAngle:-M_PI/2.0 duration:1.0];
        SKAction *moveToDireita = [SKAction moveToX:xf duration:2.0];
        SKAction *moveToEsquerda = [SKAction moveToX:90 duration:2.0];
        SKAction *rotateByEsquerda180 = [SKAction rotateByAngle:+M_PI duration:1.0];
        SKAction *group = [SKAction group:@[rotateByDireita90,moveToDireita]];
        SKAction *sequence = [SKAction sequence:@[group,rotateByEsquerda180, moveToEsquerda,rotateByDireita90]];
        
        SKAction *repeatForever = [SKAction repeatActionForever:sequence];
        
        
        //SKAction *repeat = [SKAction repeatAction:rotateByDireita count:3];
        
        [sprite runAction:repeatForever];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    //for SKSpriteNode foguete in
    
}

@end
