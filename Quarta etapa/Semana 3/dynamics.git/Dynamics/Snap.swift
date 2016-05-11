//
//  Snap.swift
//  Dynamics
//
//  Created by Rafael Moura on 22/05/15.
//  Copyright (c) 2015 Rafael Moura. All rights reserved.
//

import UIKit

class Snap: UIViewController {
    
    @IBOutlet weak var blueBox: UIView!
    
    var animator: UIDynamicAnimator?
    var snap: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleTap(sender: AnyObject) {
        
        let point = sender.locationInView(self.view)
        
        snap = UISnapBehavior(item: blueBox, snapToPoint: point)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        animator?.addBehavior(snap!)
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
