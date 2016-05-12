//
//  NewEventPopup.swift
//  EventCast
//
//  Created by Lucas Eduardo on 21/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit

class NewEventPopup: UIView {
    
    var cancelBlock: (Void -> Void)?
    var createBlock: ((eventName: String?, hashtag: String?) -> Void)?
    var checkHashtagBlock: ((hashtag: String) -> Void)?

    @IBOutlet private weak var nameEventTextFieldContainer: UIView!
    @IBOutlet private weak var nameEventTextField: UITextField!
    
    @IBOutlet private weak var hashtagTextField: UITextField!
    
    class func buildWithSize(size: CGSize) -> NewEventPopup {
        let popup = NSBundle.mainBundle().loadNibNamed("NewEvent", owner: nil, options: nil).first as! NewEventPopup
        
        popup.frame.size = size
        
        popup.nameEventTextFieldContainer.layer.borderWidth = 0.5
        popup.nameEventTextFieldContainer.layer.cornerRadius = 5.0
        popup.nameEventTextFieldContainer.layer.masksToBounds = true
        popup.nameEventTextFieldContainer.layer.borderColor = UIColor.blackColor().CGColor
        
        popup.nameEventTextField.delegate = popup
        popup.hashtagTextField.delegate = popup
        
        return popup
    }

    //MARK: - Actions
    @IBAction private func didTouchCheckHashTagBtn(sender: UIButton) {
        checkHashtagBlock?(hashtag: hashtagTextField.text!)
    }
    
    @IBAction private func didTouchCancelBtn(sender: UIButton) {
        cancelBlock?()
    }
    
    @IBAction private func didTouchFollowBtn(sender: UIButton) {
        createBlock?(eventName: nameEventTextField.text, hashtag: hashtagTextField.text)
    }

    //MARK: - Validates
    class func validEventForm(eventName eventName: String?, hashtag: String?) -> (Bool, String) {
        var errorMsg = ""
        
        if (eventName ?? "").isEmpty {
            errorMsg += NSLocalizedString("empty_event_name", comment: "Showed in hud for validating event creation")
        }
        
        return (errorMsg.isEmpty, errorMsg)
    }
}

extension NewEventPopup: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.25) {
            self.center.y -= 110
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.25) {
            self.center.y += 110
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return string != "#"
    }
}