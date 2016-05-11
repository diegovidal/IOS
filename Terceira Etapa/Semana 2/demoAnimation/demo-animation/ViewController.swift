//
//  ViewController.swift
//  demo-animation
//
//  Created by Diego Vidal on 20/04/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedView: UIView!
    
    var view1 : UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view1 = UIView(frame: animatedView.bounds)
        view1.backgroundColor = UIColor.greenColor()
        animatedView.addSubview(view1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func move(sender: UIButton) {
//        UIView.animateWithDuration(1.0, animations: {
//
//        })
        
//        UIView.animateWithDuration(1.0, delay: 0.0, options: (.CurveEaseOut | .Autoreverse), animations: { () -> Void in
//                self.animatedView.frame = CGRectOffset(self.animatedView.frame, 0.0, 100.0)
//            }, completion:{ (_) -> Void in
//                UIView.animateWithDuration(1.0, animations: { () -> Void in
//                    self.animatedView.alpha = 0.0;
//                })
//            })
//        println("HELLO")
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 30.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.animatedView.frame = CGRectOffset(self.animatedView.frame, 0.0, 100.0)
        }, completion: nil)
    }

    @IBAction func rotate(sender: UIButton) {
        UIView.animateWithDuration(1.0, animations: {
            self.animatedView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        })
    }
    
    @IBAction func hide(sender: UIButton) {
        UIView.animateWithDuration(1.0, animations: {
            self.animatedView.alpha = 0.0
        })
    }
    
    @IBAction func changeColor(sender: UIButton) {
        UIView.animateWithDuration(1.0, animations: {
            self.animatedView.backgroundColor = UIColor.blueColor()
        })
    }
    
    @IBAction func change(sender: UIButton) {
//        UIView.transitionWithView(animatedView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in
//            self.animatedView.alpha = 0.0
//        }, completion: nil)
        
        let view2 = UIView(frame: self.animatedView.bounds)
        view2.backgroundColor = UIColor.blueColor()
        
        
        UIView.transitionFromView(view1, toView: view2, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
    }
    
}

