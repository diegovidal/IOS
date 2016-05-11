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
        
        // Criando os botões
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
        
        
        
        /*
        //paredes 
        paredeEsquerda = SKNode()
        paredeEsquerda!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, 0.0, 1.0, CGRectGetHeight(self.frame)))
        addChild(paredeEsquerda!)

        paredeDireita = SKNode()
        paredeDireita!.physicsBody =
            SKPhysicsBody(edgeLoopFromRect: CGRectMake(CGRectGetWidth(self.frame) - 1.0, 0.0, 1.0, CGRectGetHeight(self.frame)))
        addChild(paredeDireita!)
        
        //chao e teto
        chao = SKNode()
        chao!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, 0.0, CGRectGetWidth(self.frame), 1.0))
        addChild(chao!)
        
        teto = SKNode()
        teto!.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 1.0))
        addChild(teto!)
        */
        
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
        node3!.physicsBody!.applyImpulse(CGVectorMake(0.0, 80.0))
    }
    
    override func update(currentTime: NSTimeInterval) {
        if isTouching {
            if touchXPosition >= 15.0 && touchXPosition <= 65.0 {
                moveEsquerda()
            }
            if touchXPosition >= 85.0 && touchXPosition <= 135.0 {
                moveDireita()
            }
            
        }
        
    }
    
    //outros Toques
    /*
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchObj = touch as! UITouch
            // executa ação
            if let node:SKShapeNode? = selectNodes[touchObj]
            {
                
                if node!.name == "btnEsquerda" {
                    moveEsquerda()
                }
                if node!.name == "btnDireita" {
                    moveDireita()
                }
                if node!.name == "btnPular" {
                    pular()
                }
            }
        }
    }
    */
    
    //fim do toque
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
       /* for touch: AnyObject in touches {
            let touchObj = touch as! UITouch
            if let exists: AnyObject? = selectNodes[touchObj] {
                selectNodes[touchObj] = nil
            }
        }*/
        
        isTouching = false
    }
    
    //toque na tela 
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        let touch: AnyObject? = touches.first
        let position = touch?.locationInNode(self)
        let node = self.nodeAtPoint(position!)
        touchXPosition = position!.x
        println("X Position: \(position?.x)")
        println("Y Position: \(position?.y)")
        isTouching = true

        /*
        for touch:AnyObject in touches {
            let location = touch.locationInNode(self)
            let node:SKShapeNode? = self.nodeAtPoint(location) as? SKShapeNode
            // nomes dos shapes
            if node?.name == "btnEsquerda" || node?.name == "btnDireita" || node?.name == "btnPular" {
                let touchObj = touch as! UITouch
                selectNodes[touchObj] = node!
            }
        }*/
        
        
        if node.name == "btnPular"
        {
            node3!.physicsBody!.applyImpulse(CGVectorMake(0.0, 6.0))
        }
        
        
        if (touchXPosition >= 180 && touchXPosition <= 570) && countQ > 0
        {
            if countQ % 2 == 0{
                var shape = SKShapeNode(rectOfSize: CGSizeMake(50.0, 10.0))
                shape.position = position!
                shape.name = "retangulo"
                shape.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50.0, 10.0))
                shape.fillColor = UIColor.blackColor()
                shape.physicsBody!.affectedByGravity = true
                shape.physicsBody!.categoryBitMask = novasFigurasCategoria
                shape.physicsBody!.collisionBitMask = novasFigurasCategoria | circuloCategoriaColisao | retanguloCategoriaColisao
                shape.physicsBody!.contactTestBitMask = circuloCategoriaColisao | novasFigurasCategoria | retanguloCategoriaColisao
                shape.physicsBody!.mass = 0.05
                shape.physicsBody!.dynamic = true
                shape.physicsBody!.allowsRotation = false
                shape.physicsBody!.usesPreciseCollisionDetection = true
                addChild(shape)
                countQ--
            }
            else
            {
                var shape = SKShapeNode(rectOfSize: CGSizeMake(30.0, 30.0))
                shape.position = position!
                shape.name = "quadrado"
                shape.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30.0, 30.0))
                shape.fillColor = UIColor.blackColor()
                shape.physicsBody!.affectedByGravity = true
                shape.physicsBody!.categoryBitMask = novasFigurasCategoria
                shape.physicsBody!.collisionBitMask = novasFigurasCategoria | circuloCategoriaColisao | retanguloCategoriaColisao
                shape.physicsBody!.contactTestBitMask = circuloCategoriaColisao | novasFigurasCategoria | retanguloCategoriaColisao
                shape.physicsBody!.mass = 0.1
                shape.physicsBody!.dynamic = true
                shape.physicsBody!.allowsRotation = false
                shape.physicsBody!.usesPreciseCollisionDetection = true
                addChild(shape)
                countQ--
            }
            

        }

        /*
        else
        {
            //var shape = SKShapeNode(rect: CGRectMake(position!.x, position!.y, 30, 30))
            var shape = SKShapeNode(rectOfSize: CGSizeMake(30.0, 30.0))
            shape.position = position!
            shape.name = "quadrado"
            shape.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30.0, 30.0))
            shape.fillColor = UIColor.blackColor()
            shape.physicsBody!.affectedByGravity = true
            shape.physicsBody!.categoryBitMask = novasFigurasCategoria
            shape.physicsBody!.collisionBitMask = novasFigurasCategoria | circuloCategoriaColisao | retanguloCategoriaColisao
            shape.physicsBody!.contactTestBitMask = circuloCategoriaColisao | novasFigurasCategoria | retanguloCategoriaColisao
            shape.physicsBody!.mass = 0.1
            shape.physicsBody!.dynamic = true
            shape.physicsBody!.allowsRotation = false
            shape.physicsBody!.usesPreciseCollisionDetection = true
            addChild(shape)
            
//            println("Area do quadrado: \(shape.physicsBody!.area)")
//            println("Densidade do quadrado: \(shape.physicsBody!.density)")
//            println("Massa do quadrado: \(shape.physicsBody!.mass)")
//            println("Area do circulo: \(node3!.physicsBody!.area)")
//            println("Densidade do circulo: \(node3!.physicsBody!.density)")
//            println("Massa do circulo: \(node3!.physicsBody!.mass)")
        
        }*/
    }
    
    
}
