//
//  EventList.swift
//  EventCast
//
//  Created by Lucas Eduardo on 28/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation
import Cent

class EventList: NSObject {
    unowned var tableView: UITableView
    var refreshControl: UIRefreshControl
    
    var events = [Event]()
    var eventsChangeListener: ((events: [Event]) -> Void)?
    
    var unfollowEventBlock: ((event: Event) -> Void)?
    var deleteEventBlock: ((event: Event) -> Void)?
    var shareEventBlock: ((event: Event) -> Void)?
    var moreOptionsBlock: ((event: Event) -> Void)?
    var refreshControlActionBlock: (Void -> Void)?
    
    var animatingRows: Bool = false
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.refreshControl = UIRefreshControl()
        
        super.init()
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.frame.width/2.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Initing refresh control for tableView
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = Config.Design.mainColor
        refreshControl.addTarget(self, action: Selector("refreshEvents"), forControlEvents: .ValueChanged)
        
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("loading", comment: "Title of refresh control"),
            attributes: [NSForegroundColorAttributeName : Config.Design.mainColor])
        
        tableView.addSubview(refreshControl)
        tableView.sendSubviewToBack(refreshControl)
    }
    
    func insertEvent(event: Event, withRowAnimation animation: UITableViewRowAnimation) {
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: events.count, inSection: 0)], withRowAnimation: animation)
        events.append(event)
        tableView.endUpdates()
        
        checkTableState()
    }
    
    func insertEvents(events: [Event], withRowAnimation animation: UITableViewRowAnimation, completionHandler: (Void -> Void)?) {
        
        guard !events.isEmpty else {
            completionHandler?()
            return
        }
        
        animatingRows = true
        for (index, event) in events.enumerate() {
            
            //adding delay with dispatchAfter to animate one row entering at a time
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.15 * Double(index) * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.insertEvent(event, withRowAnimation: animation)
                
                if (index + 1) == events.count {
                    self.animatingRows = false
                    completionHandler?()
                }
            }
        }
    }
    
    func removeEvent(event: Event, withRowAnimation animation: UITableViewRowAnimation) {
        let index = events.indexOf(event)!
        let event = events.removeAtIndex(index)
        event.destroy()
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: animation)
        tableView.endUpdates()
        
        checkTableState()
    }
    
    func removeEvents(events: [Event], withRowAnimation animation: UITableViewRowAnimation, completionHandler: (Void -> Void)?) {
        
        guard !events.isEmpty else {
            completionHandler?()
            return
        }
        
        animatingRows = true
        for (index, event) in events.enumerate() {
            
            //adding delay with dispatchAfter to animate one row entering at a time
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.15 * Double(index) * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.removeEvent(event, withRowAnimation: animation)
                
                if (index + 1) == events.count {
                    self.animatingRows = false
                    completionHandler?()
                }
            }
        }
    }
    
    func reloadEvents(events: [Event], withRowAnimation animation: UITableViewRowAnimation) {
        
        var indexPaths = [NSIndexPath]()
        for event in events {
            event.changed = false
            if let index = self.events.indexOf(event) {
                indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
            }
        }
        
        if !indexPaths.isEmpty {
            self.tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        }
        
        refreshControl.endRefreshing()
    }
    
    func refreshEvents() {
        refreshControlActionBlock?()
    }
}

//MARK: - private methods
extension EventList {
    private func checkTableState() {
        eventsChangeListener?(events: events)
        UIView.animateWithDuration(0.4) {
            self.tableView.alpha = self.events.isEmpty ? 0.0 : 1.0
        }
    }
}

//MARK: - Tableview Datasource methods
extension EventList: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        
        let event = events[indexPath.row]
        
        cell.eventTitleLabel.text = event.name
        
        cell.role = event.isOwner ? .Creator : .Subscriber
        cell.backgroundImageView.image = UIImage(named: "event_img\(indexPath.row % 4)")
        cell.hashtagLabel.text = "#\(event.hashCode)"
        
        //as requisitions are related, pass this action ahead
        cell.didTouchDeleteBtn = { [unowned self] in
            event.isOwner ? self.deleteEventBlock?(event: event) : self.unfollowEventBlock?(event: event)
        }
        
        cell.didTouchShareHashtagBtn = {
            self.shareEventBlock?(event: event)
        }
        
        cell.didTouchMoreBtn = { [unowned self] in
            self.moreOptionsBlock?(event: event)
        }
        
        cell.setupLayoutForWidth(tableView.frame.width)
        
        return cell
    }
}
