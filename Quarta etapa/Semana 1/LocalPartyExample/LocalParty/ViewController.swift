//
//  ViewController.swift
//  LocalParty
//
//  Created by Eliezio Neto on 19/02/15.
//  Copyright (c) 2015 LearnToProgram.tv. All rights reserved.
//

import UIKit

class ViewController: ResponsiveTextFieldViewController {
    var myFloatX: Double!
    var myFloatY: Double!

    @IBOutlet weak var chatTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let screenSize: CGRect = UIScreen.mainScreen().bounds
//        myFloatX = Double(screenSize.width/2)
//        myFloatY = Double(screenSize.height/2)
//        if CGFloat(self.myFloatY) >= screenSize.width {
//            self.myFloatX = myFloatX + 50
//            self.myFloatY = 16
//        }
        
        //textFieldShouldBeginEditing(chatTextField)
        //textFieldDidEndEditing(chatTextField)
        
    }

    //MARK: - Helper Methods
    
    // This is called to remove the first responder for the text field.
    func resign() {
        //self.resignFirstResponder()
    }
    
    // This triggers the textFieldDidEndEditing method that has the textField within it.
    //  This then triggers the resign() method to remove the keyboard.
    //  We use this in the "done" button action.
    func endEditingNow(){

            
            /*var labelChat   = UILabel.labelWithType(UILabelType.System) as UILabel
            //button.backgroundColor = UIColor.blackColor()
            button.setTitle("testeeee", forState: UIControlState.Normal)
            button.addTarget(self, action: "cloneButton:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setImage(UIImage(named: "Image"), forState: UIControlState.Normal)*/
//            var labelChat = UILabel(frame: CGRectMake(0, 0, 100, 100))
//            labelChat.center = CGPointMake(160, 284)
//            labelChat.textAlignment = NSTextAlignment.Center
//            labelChat.text = chatTextField.text;
//        
//            //println ("X = \(myFloatX) Y = \(myFloatY)")
//            view.addSubview(labelChat)
//            
//            //pegando o tamanho da tela...
//            let screenSize: CGRect = UIScreen.mainScreen().bounds
//            let screenWidth = screenSize.width;
//            self.myFloatY = myFloatY + 50
//            if CGFloat(self.myFloatY) >= screenSize.width {
//                self.myFloatX = myFloatX + 50
//                self.myFloatY = 16
//            }
//
//        chatTextField.text = "";
//        self.view.endEditing(true)
        
    }
    
    
    //MARK: - Delegate Methods
    // When clicking on the field, use this method.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        
        // Create a button bar for the number pad
        //let keyboardDoneButtonView = UIToolbar()
        //keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.
        //let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("endEditingNow") )
        //var toolbarButtons = [item]
        
        //Put the buttons into the ToolBar and display the tool bar
        //keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        //textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
    
    // What to do when a user finishes editting
    func textFieldDidEndEditing(textField: UITextField) {
        
        //nothing fancy here, just trigger the resign() method to close the keyboard.
        resign()
    }
    
    
    // Clicking away from the keyboard will remove the keyboard.
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // called when 'return' key pressed. return NO to ignore.
    // Requires having the text fields using the view controller as the delegate.
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        // Sends the keyboard away when pressing the "done" button
        resign()
        return true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

