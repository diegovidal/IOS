//
//  GameScene.h
//  Damn Aliens
//

//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    CMMotionManager *motionManager;
}
@end
