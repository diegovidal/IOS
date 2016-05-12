//
//  SubEventsViewController.swift
//  EventCast
//
//  Created by Lucas Eduardo on 11/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit
import AFDateHelper
import PopupContainer

class SubEventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var aPopupContainer: PopupContainer?
    
    var event: Event!
    
    lazy var subEventList: SubEventList = { [unowned self] in
        
        //setup subEventList viewModel
        
        let subEventsByDate = self.event.subEvents.sort { (subEvent1, subEvent2) -> Bool in
            subEvent1.startDate.isEarlierThanDate(subEvent2.startDate)
        }
        
        let role = self.event.isOwner ? EventRole.Creator : EventRole.Subscriber
        let subEventList = SubEventList(tableView: self.tableView, subEvents: subEventsByDate, eventRole: role)
        self.tableView.dataSource = subEventList
        self.tableView.delegate = subEventList
        self.tableView.emptyDataSetSource = subEventList;
        self.tableView.emptyDataSetDelegate = subEventList;
        
        subEventList.didTapSubEventCellCheckmark = self.toggleAttendanceForSubEvent
        subEventList.didTapSubEventCell = self.showSubEventDetailPopup
        subEventList.didTapSubEventCellDeleteBtn = self.removeSubEvent
        
        subEventList.refreshControlActionBlock = {
            self.loadAllSubEventsFromServer()
        }
        
        return subEventList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //trigger the lazy var
        subEventList.tableView.dataSource = subEventList
        subEventList.tableView.delegate = subEventList
        
        if event.isOwner {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("didTouchAddBtn:"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    func didTouchAddBtn(sender: AnyObject) {
        showNewSubEventPopup()
    }
}


//MARK: - Private methods
//MARK: - View related
extension SubEventsViewController {
    
    private func showSubEventDetailPopup(subEvent: SubEvent) {
        let popup = SubEventDetailPopup.buildWithSize(CGSize(width: view.frame.width - 40, height: 240))
        
        popup.nameSubEventLabel.text = subEvent.name
        popup.datetimeSubEventLabel.text = subEvent.startDate.toString(format: .Custom("HH:mm MMMM dd, yyyy"))
        popup.addressSubEventLabel.text = subEvent.local.isEmpty ? "-" : subEvent.local
        popup.notesSubEventLabel.text = subEvent.notes.isEmpty ? "-" : subEvent.notes
        
        aPopupContainer = PopupContainer.generatePopupWithView(popup)
        
        popup.cancelBlock = { [unowned self] in
            self.aPopupContainer?.close()
        }
        
        self.aPopupContainer?.show()
    }
    
    
    private func showNewSubEventPopup() {
        let popup = NewSubEventPopup.buildWithSize(CGSize(width: view.frame.width - 40, height: 240))

        aPopupContainer = PopupContainer.generatePopupWithView(popup)
        
        popup.cancelBlock = { [unowned self] in
            self.aPopupContainer?.close()
        }
        
        popup.createBlock = { [unowned self] (subEventName, subEventDatetime, subEventAddress, subEventNotes) in
            self.createSubEventWithName(subEventName, subEventDatetime: subEventDatetime, subEventAddress: subEventAddress, subEventNotes: subEventNotes)
            self.aPopupContainer?.close()
        }
        
        self.aPopupContainer?.show()
    }
}

//MARK: - Requisitions related
extension SubEventsViewController {
    
    private func createSubEventWithName(subEventName: String, subEventDatetime: NSDate, subEventAddress: String, subEventNotes: String) {
        let subEvent = SubEvent(name: subEventName, startDate: subEventDatetime, local: subEventAddress, notes: subEventNotes, event: event)
        self.subEventList.insertSubEvent(subEvent, withRowAnimation: .Left)
        
        SubEventClient.createSubEvent(subEvent, responseBlock: { (subEventFromServer, error) -> Void in
            if let error = error {
                SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: .Gradient)
                subEvent.destroy()
            } else {
                subEvent.identifier = subEventFromServer!.identifier
                subEventFromServer?.destroy()
                subEvent.save()
            }
        })
    }
    
    private func loadAllSubEventsFromServer() {
        
        //TODO: bug when you follow an event, enter im subevents list, unregister a notification for a subevent, then refresh the subevent list
        SubEventClient.loadSubEventsOfEvent(event) { (subEvents, error) in
            if let subEvents = subEvents {
                
                let (allChanges, _, _, removedElements) = SubEvent.syncLocalDBCollection(local: self.subEventList.subEvents, fromServer: subEvents)

                self.subEventList.subEvents = allChanges.sort { (subEvent1, subEvent2) -> Bool in
                    subEvent1.startDate.isEarlierThanDate(subEvent2.startDate)
                }

                for removedSubEvent in removedElements {
                    removedSubEvent.destroy()
                }
                
                self.subEventList.tableView.reloadData()
                self.subEventList.refreshControl.endRefreshing()
                
                SubEvent.saveAll()
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription, maskType: .Gradient)
            }
        }
    }
    
    private func toggleAttendanceForSubEvent(subEvent: SubEvent) {
        
        if subEvent.attendance {
            AttendanceClient.createAttendanceForSubEvent(subEvent, responseBlock: { (responseObject, error) in
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedFailureReason, maskType: .Gradient)
                } else {
                    subEvent.save()
                }
            })
        } else {
            AttendanceClient.deleteAttendanceForSubEvent(subEvent, responseBlock: { (responseObject, error) in
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedFailureReason, maskType: .Gradient)
                } else {
                    subEvent.save()
                }
            })
        }
        
    }
    
    private func removeSubEvent(subEvent: SubEvent) {
        let alert = UIAlertController(
            title: NSLocalizedString("delete_confirm_title", comment: "Confirm delete alert title"),
            message: NSLocalizedString("delete_confirm_msg", comment: "Confirm delete alert message"),
            preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Button title"), style: .Cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: "Button title"), style: .Default, handler: { (alert) -> Void in
            
            self.subEventList.removeSubEvent(subEvent, withRowAnimation: .Right)
            SubEventClient.deleteSubEvent(subEvent) { (_, error) in
                
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: .Gradient)
                } else {
                    subEvent.destroy()
                }
            }
            
        }))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}