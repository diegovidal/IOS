//
//  FollowEventPopup.swift
//  EventCast
//
//  Created by Lucas Eduardo on 21/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit

class FollowEventPopup: UIView {
    
    var cancelBlock: (Void -> Void)?
    var followBlock: ((hashtag : String?) -> Void)?
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var textFieldContainer: UIView!
    
    class func buildWithSize(size: CGSize) -> FollowEventPopup {
        let popup = NSBundle.mainBundle().loadNibNamed("FollowEvent", owner: nil, options: nil).first as! FollowEventPopup
        
        popup.frame.size = size
        
        popup.textFieldContainer.layer.borderWidth = 0.5
        popup.textFieldContainer.layer.cornerRadius = 5.0
        popup.textFieldContainer.layer.masksToBounds = true
        popup.textFieldContainer.layer.borderColor = UIColor.blackColor().CGColor
        
        popup.textField.delegate = popup
        return popup
    }
    
    //Mark: - Actions
    @IBAction private func didTouchCancelBtn(sender: UIButton) {
        cancelBlock?()
    }
    
    @IBAction private func didTouchFollowBtn(sender: UIButton) {
        followBlock?(hashtag: textField.text)
    }
    
    //MARK: - Validates
    class func validEventForm(hashtag hashtag: String?) -> (Bool, String) {
        var errorMsg = ""
        
        if (hashtag ?? "").isEmpty {
            errorMsg += NSLocalizedString("empty_event_hashtag", comment: "Showed in hud for validating event creation")
        }
        
        return (errorMsg.isEmpty, errorMsg)
    }
}


extension FollowEventPopup: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.25) {
            self.center.y -= 100
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.25) {
            self.center.y += 100
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return string != "#"
    }
}