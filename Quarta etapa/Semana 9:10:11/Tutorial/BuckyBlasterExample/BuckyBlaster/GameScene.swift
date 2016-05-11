//
//  GameScene.swift
//  BuckyBlaster
//
//  Created by Diego Vidal on 16/07/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        let introLabel = childNodeWithName("introLabel")
        
        if introLabel != nil{
            let fadeOut = SKAction.fadeOutWithDuration(1.0)
            
            // Faz a ação e faz a transição de scenes
            introLabel?.runAction(fadeOut, completion: {
                let doors = SKTransition.doorwayWithDuration(1.5)
                let shooterScene = ShooterScene(fileNamed: "ShooterScene")
                self.view?.presentScene(shooterScene, transition: doors)
            })
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
