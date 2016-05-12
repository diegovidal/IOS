//
//  SubEventList.swift
//  EventCast
//
//  Created by Lucas Eduardo on 11/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit
import AFDateHelper

class SubEventList: NSObject {

    unowned var tableView: UITableView
    var refreshControl: UIRefreshControl
    
    var subEvents: [SubEvent]
    var eventRole: EventRole
    
    var didTapSubEventCell: ((subEvent: SubEvent) -> Void)?
    var didTapSubEventCellCheckmark: ((subEvent: SubEvent) -> Void)?
    var didTapSubEventCellDeleteBtn: ((subEvent: SubEvent) -> Void)?
    
    var refreshControlActionBlock: (Void -> Void)?
    
    init(tableView: UITableView, subEvents:[SubEvent], eventRole: EventRole) {
        
        self.tableView = tableView
        self.subEvents = subEvents
        self.eventRole = eventRole
        self.refreshControl = UIRefreshControl()
        
        super.init()
        
        //Initing refresh control for tableView
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = Config.Design.mainColor
        refreshControl.addTarget(self, action: Selector("refreshEvents"), forControlEvents: .ValueChanged)
        
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("loading", comment: "Title of refresh control"),
            attributes: [NSForegroundColorAttributeName : Config.Design.mainColor])
        
        tableView.addSubview(refreshControl)
        tableView.sendSubviewToBack(refreshControl)
    }
    
    func refreshEvents() {
        refreshControlActionBlock?()
    }
    
    func insertSubEvent(subEvent: SubEvent, withRowAnimation animation: UITableViewRowAnimation) {
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: subEvents.count, inSection: 0)], withRowAnimation: animation)
        subEvents.append(subEvent)
        tableView.endUpdates()
    }
    
    func removeSubEvent(subEvent: SubEvent, withRowAnimation animation: UITableViewRowAnimation) {
        let index = subEvents.indexOf(subEvent)!
        subEvents.removeAtIndex(index)
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: animation)
        tableView.endUpdates()
    }
}



extension SubEventList: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.separatorStyle = (subEvents.count > 0) ? .SingleLine : .None
        return subEvents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SubEventCell", forIndexPath: indexPath) as! SubEventCell
        
        let subEvent = subEvents[indexPath.row]
        cell.orderLabel.text = String(indexPath.row + 1)
        cell.subEventTitleLabel.text = subEvent.name
        cell.subEventDateLabel.text = subEvent.startDate.toString(format: .Custom("HH:mm MMMM dd, yyyy"))
        
        cell.setupLayoutForWidth(tableView.frame.width)
        cell.markCell(subEvent.attendance, animated: false)
        
        cell.role = eventRole
        
        cell.didTapCheckmark = { [unowned self] in
            subEvent.attendance = !subEvent.attendance
            cell.markCell(subEvent.attendance, animated: true)
            self.didTapSubEventCellCheckmark?(subEvent: subEvent)
        }

        cell.didTapCell = { [unowned self] in
            self.didTapSubEventCell?(subEvent: subEvent)
        }
        
        cell.didTapDeleteBtn = { [unowned self] in
            self.didTapSubEventCellDeleteBtn?(subEvent: subEvent)
        }
        
        return cell
    }
}


extension SubEventList: UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCellWithIdentifier("TableHeader")
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

//TODO: Localize the strings of empy dataset
extension SubEventList: DZNEmptyDataSetSource {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let message = "SubEvents"
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!, NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        return NSAttributedString(string: message, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let message = "There's no subevent registered for this event yet."
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        
        let attributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 18.0)!, NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: message, attributes: attributes)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "grey-icon")!
    }
    
    func imageAnimationForEmptyDataSet(scrollView: UIScrollView!) -> CAAnimation! {

        let radians = {(degrees: CGFloat) in (degrees * CGFloat(M_PI)) / 180.0}
        
        let degrees: CGFloat = 8.0
        let animation = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        animation.duration = 3.0
        animation.cumulative = true;
        animation.repeatCount = Float.infinity
        animation.values = [0.0, radians(-degrees) * 0.25, 0.0, radians(degrees) * 0.5, 0.0, radians(-degrees), 0.0, radians(degrees), 0.0, radians(-degrees) * 0.5, 0.0, radians(degrees) * 0.25, 0.0];
        animation.keyTimes = [0.0, 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25, 0.275, 0.3]
        
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        animation.removedOnCompletion = true
        
        return animation
    }
}

extension SubEventList: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAnimateImageView(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
}