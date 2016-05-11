//
//  ViewController.swift
//  UIImagePickerController
//
//  Created by Eliezio Neto on 21/02/15.
//  Copyright (c) 2015 LearnToProgram.tv. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            var alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Device has no camera"
            alert.addButtonWithTitle("OK")
            alert.show()


        }
        else{
            let aSelector : Selector = "tap:"
            var tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
            tapGesture.numberOfTapsRequired = 1
            self.view.addGestureRecognizer(tapGesture)
            
            let bSelector : Selector = "longPress:"
            var longPress = UILongPressGestureRecognizer(target: self, action: bSelector)
            longPress.numberOfTouchesRequired = 1
            self.view.addGestureRecognizer(longPress)
        }

        
    }
    
    func tap(sender: UITapGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Ended{
            var imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage,kUTTypeMovie]
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
   func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Ended{
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            self.presentViewController(picker, animated: true, completion: nil)
        }
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary) {
        if picker.sourceType == UIImagePickerControllerSourceType.Camera{
            var imageToSave: UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
            var imageToSave1: UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
            myImageView.contentMode = .ScaleAspectFit
            myImageView.image = imageToSave1
            UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
            self.savedImageAlert()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    func savedImageAlert()
    {
        var alert:UIAlertView = UIAlertView()
        alert.title = "Saved!"
        alert.message = "Your picture was saved to Camera Roll"
        alert.delegate = self
        alert.addButtonWithTitle("Ok")
        alert.show()
    }

    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

