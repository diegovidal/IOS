//
//  CreateBeacon.swift
//  iBeacon-challenge
//
//  Created by Diego Vidal on 26/06/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class CreateBeacon: UIViewController {

    @IBOutlet weak var beaconTextField: UITextField!
    
    var majorReceived: NSNumber?
    var delegate: ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Major recebido: \(majorReceived)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createBeacon(sender: UIBarButtonItem) {
        
        let beacon = Beacon(nome: beaconTextField.text, major: majorReceived!)
        delegate?.addBeacon(beacon)
        beaconTextField.text = ""
        self.navigationController?.popViewControllerAnimated(true)
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
