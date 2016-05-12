//
//  SubEventCell.swift
//  EventCast
//
//  Created by Lucas Eduardo on 11/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit

class SubEventCell: UITableViewCell {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var subEventDateLabel: UILabel!
    @IBOutlet weak var subEventTitleLabel: UILabel!

    @IBOutlet weak var checkmarkContainer: UIView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var moreOptBtn: UIButton!
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var cellContainerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellContainerTrailingConstraint: NSLayoutConstraint!

    var didTapCheckmark: (Void -> Void)?
    var didTapCell: (Void -> Void)?
    var didTapDeleteBtn: (Void -> Void)?
    
    var role: EventRole! {
        didSet {
            checkmarkContainer.hidden = (role == EventRole.Creator)
            separator.hidden = checkmarkContainer.hidden
            
            moreOptBtn.hidden = (role == EventRole.Subscriber)
        }
    }
    
    
    func markCell(mark: Bool, animated: Bool) {
        let finalValue: CGFloat = mark ? 1.0 : 0.0
        
        if animated {
            UIView.animateWithDuration(0.15) { self.checkmarkContainer.alpha = finalValue }
        } else {
            self.checkmarkContainer.alpha = finalValue
        }
    }
    
    func setupLayoutForWidth(width: CGFloat) {
        
        //adjusts width of header
        cellContainerWidthConstraint.constant = width
        cellContainerTrailingConstraint.constant = 0.0
        
        //center text of btns
        deleteBtn.titleLabel?.textAlignment = .Center
        
        //Gesture recornizer of header
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panHeaderEvent:"))
        panGesture.delegate = self
        cellContainer.addGestureRecognizer(panGesture)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let location = touches.first?.locationInView(self) {
            if checkmarkContainer.frame.contains(location) {
                if role == EventRole.Subscriber {
                    didTapCheckmark?()
                }
            } else {
                didTapCell?()
            }
        }
        
        super.touchesBegan(touches, withEvent: event)
    }
    
    //MARK: - Actions
    @IBAction func didTouchMoreOptBtn(sender: AnyObject) {
        updateContainerConstraint((cellContainerTrailingConstraint.constant > 0.0) ? 0.0 : deleteBtn.frame.width)
    }
    
    @IBAction func didTouchDeleteBtn(sender: AnyObject) {
        didTapDeleteBtn?()
    }
    
    //MARK: - Gestures
    func panHeaderEvent(gestureRecognizer: UIPanGestureRecognizer) {
        
        let xTranslation = gestureRecognizer.translationInView(self).x
        
        var newValue = cellContainerTrailingConstraint.constant - xTranslation
        newValue = max(newValue, 0.0) //min possible value is 0.0
        
        let maxValue = deleteBtn.frame.width
        newValue = min(newValue, maxValue) //max possible value is the sum of the buttons width
        
        cellContainerTrailingConstraint.constant = newValue
        gestureRecognizer.setTranslation(CGPoint.zero, inView: self)
        
        if gestureRecognizer.state == .Ended || gestureRecognizer.state == .Cancelled {
            updateContainerConstraint((cellContainerTrailingConstraint.constant > maxValue/2.0) ? maxValue : 0.0)
        }
    }

}

//MARK: - UIGestureRecognizer delegate (UITableViewCell already conforms to UIGestureRecognizerDelegate protocol)
extension SubEventCell {
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = (gestureRecognizer as! UIPanGestureRecognizer).velocityInView(self)
        return fabs(velocity.y) < fabs(velocity.x)
    }
}

//MARK: - private methods
extension SubEventCell {
    private func updateContainerConstraint(newValue: CGFloat) {
        cellContainerTrailingConstraint.constant = newValue
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .CurveEaseInOut,
            animations: {
                self.layoutIfNeeded()
            }, completion: nil)
    }
}