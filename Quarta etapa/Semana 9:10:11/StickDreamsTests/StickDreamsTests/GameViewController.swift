//
//  GameViewController.swift
//  StickDreamsTests
//
//  Created by Douglas Santos on 14/07/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene?
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    override func viewWillLayoutSubviews() {
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        scene = GameScene(size: skView.bounds.size)
        scene!.scaleMode = SKSceneScaleMode.AspectFill
        
        skView.presentScene(scene!)
    }
    
}
