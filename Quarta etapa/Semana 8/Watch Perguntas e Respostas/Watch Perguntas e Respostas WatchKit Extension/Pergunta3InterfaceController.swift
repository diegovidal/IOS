//
//  Pergunta3InterfaceController.swift
//  Watch Perguntas e Respostas
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 07/07/15.
//  Copyright (c) 2015 bepid. All rights reserved.
//

import WatchKit
import Foundation


class Pergunta3InterfaceController: WKInterfaceController {
    let perguntas = ["Quem criou este App?"]
    let alternativas = ["Othon", "Ramon", "Marcio"]
    let respostas = ["Ramon"]
    var scores = ["scores": 0]

    @IBOutlet weak var pergunta: WKInterfaceLabel!
    @IBOutlet weak var resposta1: WKInterfaceButton!
    @IBOutlet weak var resposta2: WKInterfaceButton!
    @IBOutlet weak var resposta3: WKInterfaceButton!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if let aux = context as? [String: Int] {
            scores["scores"] = aux["scores"]
            println(scores["scores"])
        }
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

    @IBAction func respostaErrada1() {
        let aux = scores["scores"]
        scores = ["scores":aux!]
        pushControllerWithName("pergunta4", context: scores)
    }
    
    @IBAction func respostaErrada2() {
        let aux = scores["scores"]
        scores = ["scores":aux!]
        pushControllerWithName("pergunta4", context: scores)
    }
    
    @IBAction func respostaCerta() {
        let aux = scores["scores"]
        scores = ["scores":aux! + 1]
        pushControllerWithName("pergunta4", context: scores)
    }
    
    
}
