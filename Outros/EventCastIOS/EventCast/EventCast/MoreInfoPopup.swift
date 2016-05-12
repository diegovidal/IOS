//
//  MoreInfoPopup.swift
//  EventCast
//
//  Created by Lucas Eduardo on 08/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit

class MoreInfoPopup: UIView {

    var didTouchCloseBtnBlock: (Void -> Void)?
    var didChangeSwitchValueBlock: ((status: Bool) -> Void)?
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var followersNumberLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    
    class func buildWithSize(size: CGSize) -> MoreInfoPopup {
        let popup = NSBundle.mainBundle().loadNibNamed("MoreInfo", owner: nil, options: nil).first as! MoreInfoPopup
        popup.frame.size = size
        
        return popup
    }


    @IBAction func didTouchCloseBtn(sender: AnyObject) {
        didTouchCloseBtnBlock?()
    }
    
    @IBAction func didChangeSwitchValue(sender: UISwitch) {
        updateStatusLabelWithStatus(sender.on)
        didChangeSwitchValueBlock?(status: sender.on)
    }
    
    func updateStatusLabelWithStatus(status: Bool) {
        let key = status ? "active" : "mute"
        statusLabel.text = NSLocalizedString(key, comment: "Label showed to represent the status of the event: active or mute")
    }
}
