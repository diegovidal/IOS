//
//  ScoresInterfaceController.swift
//  Watch Perguntas e Respostas
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 07/07/15.
//  Copyright (c) 2015 bepid. All rights reserved.
//

import WatchKit
import Foundation


class ScoresInterfaceController: WKInterfaceController {
    var scores = ["scores": 0]

    
    @IBOutlet weak var scoresLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if let aux = context as? [String: Int] {
            scores["scores"] = aux["scores"]
            scoresLabel.setText(String(aux["scores"]!))
            println(scores["scores"])
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
