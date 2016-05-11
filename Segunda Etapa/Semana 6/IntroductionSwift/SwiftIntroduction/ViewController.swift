//
//  ViewController.swift
//  SwiftIntroduction
//
//  Created by Diego Vidal on 20/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Hello World")
        
        let apple = 3
        let string = "Eu tenho \(apple) maçãs na cesta."
        
        println(string)
        
        println(self.testeFunc("Diego Vidal", idade: 23))
        
        var 🐟 = "Fish"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testeFunc(name: String, idade: Int) -> String{
        return "meu nome é \(name) e tenho \(idade) anos"
    }


}

