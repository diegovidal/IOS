//
//  SubEventDetailPopup.swift
//  EventCast
//
//  Created by Lucas Eduardo on 15/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit


class NewSubEventPopup: UIView {
    
    var cancelBlock: (Void -> Void)?
    var createBlock: ((subEventName: String, subEventDatetime: NSDate, subEventAddress: String, subEventNotes: String) -> Void)?
    
    @IBOutlet private weak var nameSubEventTextField: UITextField!
    @IBOutlet private weak var datetimeSubEventTextField: UITextField!
    @IBOutlet private weak var addressSubEventTextField: UITextField!
    @IBOutlet private weak var notesSubEventTextField: UITextField!
    weak var datePicker: UIDatePicker!
    
    
    class func buildWithSize(size: CGSize) -> NewSubEventPopup {
        let popup = NSBundle.mainBundle().loadNibNamed("NewSubEvent", owner: nil, options: nil).first as! NewSubEventPopup
        
        popup.frame.size = size
        
        popup.nameSubEventTextField.delegate = popup
        popup.datetimeSubEventTextField.delegate = popup
        popup.addressSubEventTextField.delegate = popup
        popup.notesSubEventTextField.delegate = popup
        
        popup.initDateTimePicker()
        
        return popup
    }
    
    private func initDateTimePicker() {
        let datePicker = UIDatePicker(frame: CGRectZero)
        datePicker.datePickerMode = .DateAndTime
        datePicker.minuteInterval = 5
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker .addTarget(self, action: Selector("didChangeDatePicker:"), forControlEvents: .ValueChanged)
        datetimeSubEventTextField.inputView = datePicker
        self.datePicker = datePicker
    }
    
    //MARK: - Actions
    @IBAction private func didTouchCancelBtn(sender: UIButton) {
        cancelBlock?()
    }
    
    @IBAction private func didTouchCreateBtn(sender: UIButton) {
        createBlock?(subEventName: nameSubEventTextField.text ?? "",
            subEventDatetime: NSDate(fromString: datetimeSubEventTextField.text!, format: .Custom("HH:mm MMMM dd, yyyy")),
            subEventAddress: addressSubEventTextField.text ?? "",
            subEventNotes: notesSubEventTextField.text ?? "")
    }
    
    func didChangeDatePicker(sender: UIDatePicker) {
        datetimeSubEventTextField.text = datePicker.date.toString(format: .Custom("HH:mm MMMM dd, yyyy"))
    }
    
    //MARK: - Validates
    class func validEventForm(subEventName: String?, subEventDatetime: String?, subEventAddress: String?, subEventNotes: String?) -> (Bool, String) {
        var errorMsg = ""
        
        if (subEventName ?? "").isEmpty {
            errorMsg += "- name error\n"
        }
        
        if (subEventDatetime ?? "").isEmpty {
            errorMsg += "- subEventDatetime error"
        }
        
        return (errorMsg.isEmpty, errorMsg)
    }
}

extension NewSubEventPopup: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == datetimeSubEventTextField && (datetimeSubEventTextField.text ?? "").isEmpty {
            didChangeDatePicker(datePicker)
        }
        
        return true
    }
    
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
}