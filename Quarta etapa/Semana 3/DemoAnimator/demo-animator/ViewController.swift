//
//  ViewController.swift
//  demo-animator
//
//  Created by Diego Vidal on 05/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenBox: UIView!
    
    var animator: UIDynamicAnimator?
    var snap: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        
        let point = sender.locationInView(self.view);
        
        snap = UISnapBehavior(item: greenBox, snapToPoint: point)
        snap?.damping = 0.2
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.addBehavior(snap!);
        
    }

}

