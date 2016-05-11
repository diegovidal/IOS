//
//  InterfaceController.swift
//  Watch Perguntas e Respostas WatchKit Extension
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 07/07/15.
//  Copyright (c) 2015 bepid. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    let perguntas = ["Quem descobriu o Brasil?"]
    let alternativas = ["Pedro Álvares Cabral", "Critovão Colombo", "Pero Vaz de Caminha"]
    let respostas = ["Pedro Álvares Cabral"]
    var scores = ["scores": 0]
    
    @IBOutlet weak var pergunta: WKInterfaceLabel!
    @IBOutlet weak var resposta1: WKInterfaceButton!
    @IBOutlet weak var resposta2: WKInterfaceButton!
    @IBOutlet weak var resposta3: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        pergunta.setText(String(perguntas[0]))
        resposta1.setTitle(String(alternativas[0]))
        resposta2.setTitle(String(alternativas[1]))
        resposta3.setTitle(String(alternativas[2]))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func respostaCerta() {
        scores = ["scores":1]
        pushControllerWithName("pergunta2", context: scores)

    }
    @IBAction func respostaErrada1() {
        scores = ["scores":0]
        pushControllerWithName("pergunta2", context: scores)
    }
    
    @IBAction func respostaErrada2() {
        scores = ["scores":0]
        pushControllerWithName("pergunta2", context: scores)
    }
}
