//
//  GravityCollision.swift
//  Dynamics
//
//  Created by Rafael Moura on 22/05/15.
//  Copyright (c) 2015 Rafael Moura. All rights reserved.
//

import UIKit

class GravityCollision: UIViewController,UICollisionBehaviorDelegate {
    
    @IBOutlet weak var blueBox: UIView!
    @IBOutlet weak var redBarrierTop: UIView!
    @IBOutlet weak var redBarrierBotton: UIView!
    @IBOutlet weak var greenBox: UIView!
    
    var animator:UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gravity = UIGravityBehavior(items: [greenBox,blueBox])
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.addBehavior(gravity!)
        
        collision = UICollisionBehavior(items: [greenBox,blueBox])
        collision?.translatesReferenceBoundsIntoBoundary = true
        
        collision?.addBoundaryWithIdentifier("top", forPath: UIBezierPath(rect: redBarrierTop.frame))
        collision?.addBoundaryWithIdentifier("botton", forPath: UIBezierPath(rect: redBarrierBotton.frame))
        
        animator?.addBehavior(collision!)
        
        
        
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
