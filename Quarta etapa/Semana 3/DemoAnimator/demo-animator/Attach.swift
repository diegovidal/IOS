//
//  Attach.swift
//  demo-animator
//
//  Created by Diego Vidal on 05/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class Attach: UIViewController {

    @IBOutlet weak var blueBox: UIView!
    @IBOutlet weak var redBox: UIView!
    
    var animator: UIDynamicAnimator?
    var attach: UIAttachmentBehavior?
    var gravity: UIGravityBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        attach = UIAttachmentBehavior(item: blueBox, attachedToAnchor: redBox.center)
        attach?.frequency = 0.5
        attach?.length = 1.0
        gravity = UIGravityBehavior(items: [blueBox])
        
        animator?.addBehavior(attach!)
        animator?.addBehavior(gravity!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func panHandler(sender: UIPanGestureRecognizer) {
        
        let panLocation = sender.locationInView(self.view)
        attach?.anchorPoint = panLocation
        redBox.center = panLocation
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
