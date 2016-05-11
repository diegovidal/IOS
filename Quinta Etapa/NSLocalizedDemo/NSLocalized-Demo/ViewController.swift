//
//  ViewController.swift
//  NSLocalized-Demo
//
//  Created by Diego Vidal on 18/08/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var currencyOutlet: UILabel!
    @IBOutlet weak var valueOutlet: UILabel!
    @IBOutlet weak var myMessageOutlet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labelCountry.text = NSLocalizedString("countryKey", comment: "country")
        imageOutlet.image = UIImage(named: NSLocalizedString("flagKey", comment: "flag"))
        valueOutlet.text = NSLocalizedString("valueKey", comment: "value")
        myMessageOutlet.text = NSLocalizedString("helloKey", comment: "message")
        
        let local = NSLocale(localeIdentifier: NSLocalizedString("localKey", comment: "local"))
        currencyOutlet.text = local.objectForKey(NSLocaleCurrencySymbol) as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

