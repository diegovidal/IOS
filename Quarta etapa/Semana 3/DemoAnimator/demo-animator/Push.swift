//
//  Push.swift
//  demo-animator
//
//  Created by Diego Vidal on 05/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class Push: UIViewController {

    @IBOutlet weak var blueBox: UIView!
    @IBOutlet weak var redBox: UIView!
    
    var animator: UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let continuousPush = UIPushBehavior(items: [blueBox], mode: UIPushBehaviorMode.Continuous)
        let instataneousPush = UIPushBehavior(items: [redBox], mode: UIPushBehaviorMode.Instantaneous)
        let dynamicItem = UIDynamicItemBehavior(items: [redBox])
        dynamicItem.resistance = 0.0
        
        continuousPush.setAngle(CGFloat(M_PI_2), magnitude: 0.2)
        instataneousPush.setAngle(CGFloat(M_PI_2), magnitude: 0.2)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        animator?.addBehavior(continuousPush)
        animator?.addBehavior(instataneousPush)
        

        // Do any additional setup after loading the view.
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
