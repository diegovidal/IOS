//
//  GameScene.m
//  Damn Aliens
//
//  Created by Diego Vidal on 03/03/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
//    SKSpriteNode *player = (SKSpriteNode *) [self childNodeWithName:@"//player"];
//    SKConstraint *constraintX = [SKConstraint positionX:[SKRange rangeWithLowerLimit:(-self.frame.size.width/2) + (player.size.width/2) upperLimit:(self.frame.size.width/2) - (player.size.width/2)]];
//    [player setConstraints:@[constraintX]];
    
    motionManager = [[CMMotionManager alloc] init];
    [motionManager startAccelerometerUpdates];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime{
    CMAccelerometerData *acceeletrometerData = motionManager.accelerometerData;
    SKSpriteNode *player = (SKSpriteNode *) [self childNodeWithName:@"//player"];
    
    [player.physicsBody applyForce:CGVectorMake(1000 *acceeletrometerData.acceleration.x, 0)];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self processUserMotionForUpdate:currentTime];
}

@end
