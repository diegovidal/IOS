//
//  Gravity.swift
//  Dynamics
//
//  Created by Rafael Moura on 03/06/15.
//  Copyright (c) 2015 Rafael Moura. All rights reserved.
//

import UIKit

class Gravity: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var redBox: UIView!
    @IBOutlet weak var blueBox: UIView!
    @IBOutlet weak var greenBox: UIView!
    
    var animator: UIDynamicAnimator?
    var animator2: UIDynamicAnimator?
    
    var gravity: UIGravityBehavior?
    var gravity2: UIGravityBehavior?
    
    var collision: UICollisionBehavior?
    var collision2: UICollisionBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gravity = UIGravityBehavior(items: [blueBox])
        gravity?.gravityDirection = CGVector(dx: 0, dy: 1.0)
        
        gravity2 = UIGravityBehavior(items: [redBox,greenBox])
        gravity2?.gravityDirection = CGVector(dx: 0, dy: 0.2)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator2 = UIDynamicAnimator(referenceView: self.view)
        
        collision = UICollisionBehavior(items: [blueBox])
        collision!.collisionDelegate = self;
        
        collision2 = UICollisionBehavior(items: [redBox,greenBox])
        collision2!.collisionDelegate = self;
        
        //Setar colisao da borda da view
        collision!.translatesReferenceBoundsIntoBoundary = true
        collision2?.translatesReferenceBoundsIntoBoundary = true
        
        animator?.addBehavior(gravity!)
        animator2?.addBehavior(gravity2!)
        
        animator?.addBehavior(collision!)
        animator2?.addBehavior(collision2!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
