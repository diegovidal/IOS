//
//  ViewController.swift
//  Watch Image Communication Exchange
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 07/07/15.
//  Copyright (c) 2015 bepid. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage

            if let group = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.br.com.bepid.Watch-Image-Communication-Exchange")?.relativePath {
                let imageData = UIImagePNGRepresentation(pickedImage)
                let myEncodedImageData = NSKeyedArchiver.archivedDataWithRootObject(imageData)
                let path = group.stringByAppendingPathComponent("Library").stringByAppendingPathComponent("Image")
                myEncodedImageData.writeToFile(path, atomically: true)
            }

            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

