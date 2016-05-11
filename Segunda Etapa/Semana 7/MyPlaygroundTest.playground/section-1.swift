// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func mostraNome(#nome: String) -> String{
    return "Olá " + nome
}

println(mostraNome(nome: "Diego"))

class Contato {
    var nome : String
    var telefone = ""
    
    init(nome: String, telefone: String){
        self.nome = nome
        self.telefone = telefone
    }
    
}

struct ContatoS {
    var teste = 0
}


var diego = Contato(nome: "Diego", telefone: "85251091")

// Sempre Maiúsculo
enum Days: String{
    case Monday = "Monday"
    case Sunday = "Sunday"
}

let currentDay: Days = .Monday
currentDay.rawValue


extension String{
    func meuMetodo() -> String{
        return self + "aaaa"
    }
}


var teste = "fdsfs"
teste.meuMetodo()

//---------------------------------------------------------------------------------------------------------------------------------------





