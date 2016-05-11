//
//  Push.swift
//  Dynamics
//
//  Created by Rafael Moura on 22/05/15.
//  Copyright (c) 2015 Rafael Moura. All rights reserved.
//

import UIKit

class Push: UIViewController {
    
    @IBOutlet weak var redBox: UIView!
    @IBOutlet weak var blueBox: UIView!
    
    var animator:UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let continuousPush = UIPushBehavior(items: [redBox], mode: UIPushBehaviorMode.Continuous)
        let instantaneousPush = UIPushBehavior(items: [blueBox], mode: UIPushBehaviorMode.Instantaneous)
        let dynamicItem = UIDynamicItemBehavior(items: [blueBox])
        dynamicItem.resistance = 0.0
        
        continuousPush.setAngle(CGFloat(M_PI_2), magnitude: 0.2)
        instantaneousPush.setAngle(CGFloat(M_PI_2), magnitude: 0.2)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.addBehavior(continuousPush)
        animator?.addBehavior(instantaneousPush)
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
