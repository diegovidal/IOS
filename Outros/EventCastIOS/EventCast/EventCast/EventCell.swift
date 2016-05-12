//
//  EventCell.swift
//  EventCast
//
//  Created by Lucas Eduardo on 29/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation

enum EventRole {
    case Creator
    case Subscriber
}

class EventCell: UITableViewCell {
    
    var role: EventRole! {
        didSet {
            let roleKey = (self.role == .Creator) ? "creator" : "subscriber"
            eventRoleLabel.text = NSLocalizedString(roleKey, comment: "Msg showed in role label inside event cell")

            let deleteBtnKey = (self.role == .Creator) ? "remove_event" : "unfollow"
            deleteBtn.setTitle(NSLocalizedString(deleteBtnKey, comment: "Msg of delete btn: unfollow if subscriber, delete if creator."), forState: .Normal)
        }
    }
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventRoleLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headerEventCell: UIView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var shareHashtagBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var headerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerWidthConstraint: NSLayoutConstraint!
    
    var didTouchDeleteBtn: (Void -> Void)?
    var didTouchShareHashtagBtn: (Void -> Void)?
    var didTouchMoreBtn: (Void -> Void)?
    
    private var totalButtonsWidth: CGFloat {
        var total =  deleteBtn.frame.width + shareHashtagBtn.frame.width
        if role == .Creator {
            total += moreBtn.frame.width
        }
        
        return total
    }
    
    func setupLayoutForWidth(width: CGFloat) {
        
        //draw shadow
        layer.shadowColor = UIColor.blackColor().CGColor;
        layer.shadowOffset = CGSizeMake(-2, 2);
        layer.shadowOpacity = 0.3;
        layer.shadowRadius = 1.0;
        clipsToBounds = false;
        layer.masksToBounds = false;
        
        //adjusts width of header
        headerWidthConstraint.constant = width - 20.0
        headerTrailingConstraint.constant = 0.0
        
        //center text of btns
        deleteBtn.titleLabel?.textAlignment = .Center
        shareHashtagBtn.titleLabel?.textAlignment = .Center
        moreBtn.titleLabel?.textAlignment = .Center
        
        //Gesture recornizer of header
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panHeaderEvent:"))
        headerEventCell.addGestureRecognizer(panGesture)
    }
    
    //MARK: - Actions
    @IBAction func didTouchOptionsBtn(sender: AnyObject) {
        updateHeaderConstraint((headerTrailingConstraint.constant > 0.0) ? 0.0 : totalButtonsWidth)
    }
    
    @IBAction func didTouchUnfollowBtn(sender: AnyObject) {
        didTouchDeleteBtn?()
    }
    
    @IBAction func didTouchShareHashtagBtn(sender: AnyObject) {
        didTouchShareHashtagBtn?()
    }
    
    @IBAction func didTouchMoreBtn(sender: AnyObject) {
        didTouchMoreBtn?()
    }
    
    //MARK: - Gestures
    func panHeaderEvent(gestureRecognizer: UIPanGestureRecognizer) {
        
        let xTranslation = gestureRecognizer.translationInView(self).x
        
        var newValue = headerTrailingConstraint.constant - xTranslation
        newValue = max(newValue, 0.0) //min possible value is 0.0
        
        let maxValue = totalButtonsWidth
        newValue = min(newValue, maxValue) //max possible value is the sum of the buttons width
        
        headerTrailingConstraint.constant = newValue
        gestureRecognizer.setTranslation(CGPoint.zero, inView: self)
        
        if gestureRecognizer.state == .Ended || gestureRecognizer.state == .Cancelled {
            updateHeaderConstraint((headerTrailingConstraint.constant > maxValue/2.0) ? maxValue : 0.0)
        }
    }
}

//MARK: - private methods
extension EventCell {
    private func updateHeaderConstraint(newValue: CGFloat) {
        headerTrailingConstraint.constant = newValue
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .CurveEaseInOut,
            animations: {
                self.layoutIfNeeded()
            }, completion: nil)
    }
}
