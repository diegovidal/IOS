//
//  ViewController.swift
//  core-animation
//
//  Created by Diego Vidal on 20/04/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hide(sender: UIButton) {
        
        // Animação não intrusiva
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.duration = 1.0
        
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        fadeAnimation.autoreverses = true
        fadeAnimation.repeatCount = 3 // Float.infinity
        
        animatedView.layer.addAnimation(fadeAnimation, forKey: nil)
        
        //animatedView.layer.opacity = 0.0
    }

    @IBAction func rotate(sender: UIButton) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            print("ACABOU")
        }
        
        animatedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        animatedView.layer.position.y = animatedView.center.y - animatedView.frame.size.height/2.0
        
        let rotate = CAKeyframeAnimation(keyPath: "transform.rotation.x")
        rotate.values = [0.0, M_PI_2, M_PI, 3*M_PI/2.0, 2*M_PI]
        rotate.duration = 2.0
        rotate.keyTimes = [0.0, 0.1, 0.2, 0.8, 1.0]
        animatedView.layer.addAnimation(rotate, forKey: "rotate")
        
        CATransaction.commit()
    }
    
    @IBAction func group(sender: UIButton) {
        
        let widthAnim = CAKeyframeAnimation(keyPath: "borderWidth")
        widthAnim.values = [1.0, 10.0, 5.0, 30.0, 0.5, 15.0, 2.0, 50.0, 0.0]
        
        let colorAnim = CAKeyframeAnimation(keyPath: "borderColor")
        animatedView.layer.borderColor = UIColor.redColor().CGColor
        colorAnim.values = [UIColor.greenColor().CGColor, UIColor.blackColor().CGColor, UIColor.blueColor().CGColor]
        
        let group = CAAnimationGroup()
        group.animations = [widthAnim, colorAnim]
        group.duration = 5.0
        animatedView.layer.addAnimation(group, forKey: "borderChange")
    }
    
    @IBAction func transition(sender: UIButton) {
        
        let view2 = UIView(frame: animatedView.frame)
        view2.backgroundColor = UIColor.blueColor()
        view.addSubview(view2)
        
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 2.0
        
        animatedView.layer.addAnimation(transition, forKey: "transition")
        view2.layer.addAnimation(transition, forKey: "transition2")
        
        animatedView.hidden = true
    }
}

