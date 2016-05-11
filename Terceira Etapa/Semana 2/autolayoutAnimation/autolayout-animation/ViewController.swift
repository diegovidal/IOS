//
//  ViewController.swift
//  autolayout-animation
//
//  Created by Diego Vidal on 22/04/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var topAnimationViewConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func coreAnimation(sender: UIButton) {
        
        let moveAnimation = CABasicAnimation(keyPath: "position.y")
        moveAnimation.fromValue = animationView.layer.position.y
        moveAnimation.toValue = animationView.layer.position.y + 100.0
        moveAnimation.duration = 1.0
        
        animationView.layer.addAnimation(moveAnimation, forKey: "move")
        
        topAnimationViewConstraint.constant += 100.0
        
    }

    @IBAction func uikitDown(sender: UIButton) {
        
        self.topAnimationViewConstraint.constant += 100.0
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
                // Ele força o recarregemento das subviews
                self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @IBAction func uikitUp(sender: UIButton) {
        
        self.topAnimationViewConstraint.constant -= 100.0
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
}

