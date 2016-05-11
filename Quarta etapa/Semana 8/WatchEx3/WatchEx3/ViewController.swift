//
//  ViewController.swift
//  WatchEx3
//
//  Created by Oton Braga on 07/07/15.
//  Copyright (c) 2015 Othon. All rights reserved.
//

import UIKit

class viewController: UIViewController {
    
    let imagePikerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePikerController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showImagePicker(sender: UIButton) {
        imagePikerController.allowsEditing = false
        imagePikerController.sourceType = .PhotoLibrary
        
        presentViewController(imagePikerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            if let group = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.br.com.bepid.Watch-Image-Communication-Exchange")?.relativePath {
                let imageData = U6IImagePNGRepresentation(pickedImage)
                let myEncodedImageData = NSKeyedArchiver.archivedDataWithRootObject(imageData)
                let path = group.stringByAppendingPathComponent("Library").stringByAppendingPathComponent("Image")
                myEncodedImageData.writeToFile(path, atomically: true)
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

