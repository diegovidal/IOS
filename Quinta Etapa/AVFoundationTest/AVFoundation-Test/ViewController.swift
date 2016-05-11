//
//  ViewController.swift
//  AVFoundation-Test
//
//  Created by Diego Vidal on 18/08/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    var playerController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButton(sender: UIButton) {
        
        if let url = NSBundle.mainBundle().URLForResource("IMG_0255", withExtension: ".MOV"){
            let playerItem = AVPlayerItem(URL: url)
            let player = AVPlayer(playerItem: playerItem)
            playerController.player = player
            
            self.presentViewController(playerController, animated: true, completion: nil)
            
            player.play()
            
            var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            button.frame = CGRectMake(100, 100, 100, 50)
            button.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
           button.backgroundColor = UIColor.blueColor()
            // não pode interagir
            //playerController.contentOverlayView
            
            playerController.view.addSubview(button)
        }
    }
    
    func buttonAction(){
        playerController.player.rate = playerController.player.rate*2
    }

}

