//
//  Attach.swift
//  Dynamics
//
//  Created by Rafael Moura on 22/05/15.
//  Copyright (c) 2015 Rafael Moura. All rights reserved.
//

import UIKit

class Attach: UIViewController {

    @IBOutlet weak var anchor: UIView!
    @IBOutlet weak var greenBox: UIView!
    
    var animator:UIDynamicAnimator?
    var attachment: UIAttachmentBehavior?
    var gravity: UIGravityBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        attachment = UIAttachmentBehavior(item: greenBox, attachedToAnchor: anchor.center)
        gravity = UIGravityBehavior(items: [greenBox])
        attachment?.frequency = 5
        attachment?.length = 100
        
        animator?.addBehavior(attachment!)
        animator?.addBehavior(gravity!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(sender: AnyObject) {
        let panLocation = sender.locationInView(view)
        attachment?.anchorPoint = panLocation
        anchor.center = panLocation
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
