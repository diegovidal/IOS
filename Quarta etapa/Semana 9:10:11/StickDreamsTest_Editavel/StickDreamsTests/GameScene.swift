//
//  GameScene.swift
//  StickDreamsTests
//
//  Created by Douglas Santos on 14/07/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //categorias para colisão
    let circuloCategoriaColisao: UInt32 = 0x1 << 1
    let retanguloCategoriaColisao: UInt32 = 0x1 << 2
    let mascaraColisao: UInt32 = 0x1 << 3
    let novasFigurasCategoria: UInt32 = 0x1 << 4
    
    // elementos da geometria
    var node1: SKShapeNode?
    var node2: SKShapeNode?
    var node3: SKShapeNode?
    var node4: SKShapeNode?
    var paredeEsquerda: SKNode?
    var paredeDireita: SKNode?
    var chao: SKNode?
    var teto: SKNode?
    
    //botões
    var btnEsquerda: SKShapeNode?
    var btnDireita: SKShapeNode?
    var btnPular: SKShapeNode?
    
    var node: AnyObject!
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
    }

    override init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.contactDelegate = self
        
        //seta o anchor point
        anchorPoint = CGPointMake(0.0, 0.0)
        
        //mundo físico
        physicsWorld.gravity = CGVectorMake(0.0, -1.8)
        physicsWorld.speed = 1.0
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        
        // Verificando o tamanho da tela
        println("Tamanho: \(size.width), \(size.height)")
        backgroundColor = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0) // seta a cor
        // permitir interação do usuário
        userInteractionEnabled = true
        
        //criando os botões
        btnEsquerda = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
        btnEsquerda!.position = CGPointMake(40, 50)
        btnEsquerda!.fillColor = UIColor.orangeColor()
        btnEsquerda!.name = "btnEsquerda"
        addChild(btnEsquerda!)
        
        btnDireita = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
        btnDireita!.position = CGPointMake(110, 50)
        btnDireita!.fillColor = UIColor.orangeColor()
        btnDireita!.name = "btnDireita"
        addChild(btnDireita!)
        
        btnPular = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
        btnPular!.position = CGPointMake(self.size.width - 80, 50)
        btnPular!.fillColor = UIColor.blueColor()
        btnPular!.name = "btnPular"
        addChild(btnPular!)
        
        //criar os nodes
        node1 = SKShapeNode(rect: CGRectMake(0.0, size.height / 2.0, size.width / 3, 10))
        node1!.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        node1!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, size.height / 2.0, size.width / 3, 10))
        node1!.physicsBody!.affectedByGravity = false
        node1!.physicsBody!.categoryBitMask = retanguloCategoriaColisao
        node1!.physicsBody!.dynamic = true
        node1!.physicsBody!.collisionBitMask = mascaraColisao | circuloCategoriaColisao
        node1!.physicsBody!.contactTestBitMask = circuloCategoriaColisao | novasFigurasCategoria
        addChild(node1!)
        
        node2 = SKShapeNode(rect: CGRectMake(size.width, size.height / 2.0 , -(size.width / 3), 10))
        node2!.fillColor = UIColor.whiteColor()
        
        node2!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(size.width, size.height / 2.0, -(size.width / 3), 10))
        node2!.physicsBody!.affectedByGravity = false
        node2!.physicsBody!.categoryBitMask = retanguloCategoriaColisao
        node2!.physicsBody!.dynamic = true
        node2!.physicsBody!.collisionBitMask = mascaraColisao | circuloCategoriaColisao
        node2!.physicsBody!.contactTestBitMask = circuloCategoriaColisao | novasFigurasCategoria
        addChild(node2!)
        
        //adicionar um circulo
        node3 = SKShapeNode(circleOfRadius: 15.0)
        node3!.name = "circulo"
        node3!.fillColor = UIColor.blackColor()
        node3!.position = CGPointMake((size.width / 2.0) + size.width / 4, size.height / 2.0 + 50)
        node3!.strokeColor = UIColor.blackColor()
        node3!.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        node3!.physicsBody!.dynamic = true
        node3!.physicsBody!.angularDamping = 1.0
        node3!.physicsBody!.linearDamping = 1.0
        node3!.physicsBody!.categoryBitMask = circuloCategoriaColisao
        node3!.physicsBody!.contactTestBitMask = novasFigurasCategoria | circuloCategoriaColisao | retanguloCategoriaColisao
        node3!.physicsBody!.collisionBitMask = circuloCategoriaColisao | retanguloCategoriaColisao | novasFigurasCategoria
        addChild(node3!)

        }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        
        if collision == (circuloCategoriaColisao | novasFigurasCategoria){
            println("contato")
        }
        
        if collision == (retanguloCategoriaColisao | novasFigurasCategoria){
            println("contato 2")
            
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    //elements
    //var selectNodes: [UITouch:SKShapeNode] = [UITouch: SKShapeNode]()
    var isTouching = false
    var touchXPosition: CGFloat = 0
    var countQ = 5
    
    func moveEsquerda(){
        node3!.physicsBody!.applyImpulse(CGVectorMake(-0.1, 0.0))
    }
    
    func moveDireita(){
        node3!.physicsBody!.applyImpulse(CGVectorMake(0.1, 0.0))
    }
    
    func pular(){
        node3!.physicsBody!.applyImpulse(CGVectorMake(0.0, 6.0))
    }
    
    override func update(currentTime: NSTimeInterval) {
        if  isTouching{
            if node.name == "btnEsquerda" {
                moveEsquerda()
            }
            if node.name == "btnDireita" {
                moveDireita()
            }
        }
    }
    
    
    //toque em movimento
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("moveu o tap")
        let touch: AnyObject? = touches.first
        let position = touch?.locationInNode(self)
        var node_aux = self.nodeAtPoint(position!)
        
        if node_aux.name == "btnDireita" || node_aux.name == "btnEsquerda"{
            node = node_aux
            isTouching = true
        }
    }

    
    //fim do toque
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        print("tirou o tap")
        let touch: AnyObject? = touches.first
        let position = touch?.locationInNode(self)
        var node = self.nodeAtPoint(position!)
        
        if (node.name == "btnDireita" || node.name == "btnEsquerda"){
            isTouching = false
        }
    }
    
    //toque na tela 
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        println("pressionou o botão")
        let touch: AnyObject? = touches.first
        let position = touch?.locationInNode(self)
        var node_aux = self.nodeAtPoint(position!)
        
        if node_aux.name == "btnDireita" || node_aux.name == "btnEsquerda"{
            node = node_aux
            isTouching = true
        }
        
        if node_aux.name == "btnPular"{
            pular()
        }
    }
    
    
}
