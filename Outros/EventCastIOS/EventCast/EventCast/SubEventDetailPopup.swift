//
//  SubEventDetailPopup.swift
//  EventCast
//
//  Created by Lucas Eduardo on 15/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit


class SubEventDetailPopup: UIView {
    
    var cancelBlock: (Void -> Void)?
    
    @IBOutlet weak var nameSubEventLabel: UILabel!
    @IBOutlet weak var datetimeSubEventLabel: UILabel!
    @IBOutlet weak var addressSubEventLabel: UILabel!
    @IBOutlet weak var notesSubEventLabel: UILabel!
    
    class func buildWithSize(size: CGSize) -> SubEventDetailPopup {
        let popup = NSBundle.mainBundle().loadNibNamed("SubEventDetail", owner: nil, options: nil).first as! SubEventDetailPopup
        
        popup.frame.size = size
        
        return popup
    }
    
    //MARK: - Actions
    @IBAction private func didTouchCancelBtn(sender: UIButton) {
        cancelBlock?()
    }
}
