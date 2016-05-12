//
//  ViewController.swift
//  EventCast
//
//  Created by Lucas Eduardo on 14/10/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import UIKit
import PopupContainer

class MainViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var helpBtn: UIBarButtonItem!
    @IBOutlet weak var actionBtn: UIBarButtonItem!
    @IBOutlet weak var logoContainerNavBar: UIView!
    
    var aPopupContainer: PopupContainer?
    
    lazy var eventList: EventList = { [unowned self] in
        
        //setup eventList viewModel
        let eventList = EventList(tableView: self.tableView)
        
        eventList.eventsChangeListener = { [unowned self] (events) in
            UIView.animateWithDuration(0.25) {
                self.logoContainerNavBar.alpha = events.isEmpty ? 0.0 : 1.0
            }
        }
        
        eventList.unfollowEventBlock = self.unfollowEvent
        eventList.deleteEventBlock = self.deleteEvent
        eventList.shareEventBlock = self.shareEvent
        eventList.moreOptionsBlock = self.showMoreOptionsPopup
        eventList.refreshControlActionBlock = {
            self.loadAllEventsFromServer()
        }
        
        return eventList
    }()
    
    lazy var eventsMenu: PopMenu = {
        
        let item1 = MenuItem(title: NSLocalizedString("new_event", comment: "New event button title"), iconName: "new-event-icon")
        let item2 = MenuItem(title: NSLocalizedString("follow_event", comment: "Follow event button title"), iconName: "follow-event-icon")
        
        let menu = PopMenu(frame: self.view.bounds, items: [item1, item2])
        menu.menuAnimationType = .Sina
        menu.perRowItemCount = 1
        
        menu.didSelectedItemCompletion = { [unowned self] (selectedItem) in
            selectedItem.index == 0 ? self.showNewEventPopup() : self.showFollowEventPopup()
        }
        
        return menu
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logo in nav bar and tableView are initially hidden
        logoContainerNavBar.alpha = 0.0
        tableView.alpha = 0.0
        
        /**
        behaviour:
        1 - If first time opened, create phoneUser locally, and call loadEvents to create phoneUser remotly
        2 - If not, load all events of the user from coredata, but call loadEvents in background to perform an eventual synchronization.
        */
        
        if PhoneUser.identifier == nil {
            actionBtn.enabled = false
            helpBtn.enabled = false
            SVProgressHUD.showWithStatus(NSLocalizedString("setup", comment: "Title for hud when creating phone user"), maskType: .Gradient)
            
            PhoneUser.createPhoneUser()
        }
        
        //Load Data From DB
        let localEvents = Event.all()
        
        //TODO: if events.count of db == 0, put progress hud until response from server arrives
        eventList.insertEvents(localEvents, withRowAnimation: .Left, completionHandler: {
            //TODO: If events from server is fast than this animations?
        })
        
        //TODO: sync subevents
        loadAllEventsFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Actions
    @IBAction func didTouchMenuBtn(sender: AnyObject) {
        showPopMenu()
    }
    
    @IBAction func didTouchHelpBtn(sender: AnyObject) {
        showHelpActionSheet()
    }
    
    //MARK: - Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let subEventsController = segue.destinationViewController as! SubEventsViewController
        
        let event = eventList.events[tableView.indexPathForSelectedRow!.row]
        subEventsController.event = event
    }
}


//MARK: - Private methods
//MARK: - View related
extension MainViewController {
    private func showPopMenu() {
        eventsMenu.isShowed ? eventsMenu.dismissMenu() : eventsMenu.showMenuAtView(navigationController!.view)
    }
    
    private func showHelpActionSheet () {
        
        let actionSheet = AHKActionSheet(title: NSLocalizedString("help", comment: "Title of the help action sheet"))
        
        actionSheet.blurTintColor = UIColor(white: 0.0, alpha: 0.6)
        actionSheet.blurRadius = 8.0;
        actionSheet.buttonHeight = 50.0;
        actionSheet.cancelButtonHeight = 50.0;
        actionSheet.cancelButtonShadowColor = UIColor(white: 0.0, alpha: 0.1)
        actionSheet.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        actionSheet.selectedBackgroundColor = UIColor(white: 0.0, alpha: 0.15)
        
        let defaultFont : UIFont! = UIFont(name: "Helvetica-light", size: 17)//[UIFont fontWithName:@"Avenir" size:17.0f];
        actionSheet.buttonTextAttributes = [ NSFontAttributeName : defaultFont,
            NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        actionSheet.cancelButtonTitle = NSLocalizedString("cancel", comment: "Cancel title inside help action sheet")
        actionSheet.cancelButtonTextAttributes = [ NSFontAttributeName : defaultFont,
            NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        actionSheet.addButtonWithTitle(NSLocalizedString("f.a.q.", comment: "Frequently Asked Questions button inside help action sheet"), type: .Default) { (actionSheet)  in
            print("tapped")
        }
        
        actionSheet.addButtonWithTitle(NSLocalizedString("video_tutorial", comment: "Video Turorial button inside help action sheet"), type: .Default) { (actionSheet)  in
            print("tapped")
        }
        
        actionSheet.addButtonWithTitle(NSLocalizedString("about", comment: "About button inside help action sheet"), type: .Default) { (actionSheet)  in
            print("tapped")
        }
        
        actionSheet.addButtonWithTitle(NSLocalizedString("contact_us", comment: "Contact Us button inside help action sheet"), type: .Default) { (actionSheet)  in
            print("tapped")
        }
        
        actionSheet.show()
    }
    
    private func showNewEventPopup() {
        let popup = NewEventPopup.buildWithSize(CGSize(width: view.frame.width - 40, height: 240))
        
        aPopupContainer = PopupContainer.generatePopupWithView(popup)
        
        popup.cancelBlock = { [unowned self] in
            self.aPopupContainer?.close()
        }
        
        popup.checkHashtagBlock = { [unowned self] hashtag in
            self.checkHashtag(hashtag,
                availableBlock: {
                    SVProgressHUD.showSuccessWithStatus(NSLocalizedString("available", comment: "Available hud feedback"), maskType: .Gradient)
                },
                unavailableBlock: {
                    SVProgressHUD.showErrorWithStatus(NSLocalizedString("not_available", comment: "Not Available hud feedback"), maskType: .Gradient)
            })
        }
        
        popup.createBlock = createEvent
        
        self.aPopupContainer?.show()
    }
    
    private func showFollowEventPopup() {
        let popup = FollowEventPopup.buildWithSize(CGSize(width: view.frame.width - 40, height: 130))
        
        aPopupContainer = PopupContainer.generatePopupWithView(popup)
        popup.cancelBlock = { [weak self] in
            self?.aPopupContainer?.close()
        }
        
        popup.followBlock = followHashtag
        
        aPopupContainer?.show()
    }
    
    private func shareEvent(event: Event) {
        let shareMsg = String(format: NSLocalizedString("share_event", comment: ""), event.hashCode)
        let activityController = UIActivityViewController(activityItems: [shareMsg], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    private func showMoreOptionsPopup(event: Event) {
        let popup = MoreInfoPopup.buildWithSize(CGSize(width: view.frame.width - 40, height: 107))
        
        aPopupContainer = PopupContainer.generatePopupWithView(popup)
        
        popup.eventTitleLabel.text = event.name
        popup.followersNumberLabel.text = event.subscribersCount.stringValue
        popup.statusSwitch.on = event.status
        popup.updateStatusLabelWithStatus(event.status)
        
        popup.didChangeSwitchValueBlock = { [unowned self] status in
            self.changeStatus(status, forEvent: event)
        }
        
        popup.didTouchCloseBtnBlock = { [unowned self] in
            self.aPopupContainer?.close()
        }
        
        aPopupContainer?.show()
    }
}

//MARK: - Requisitions related
extension MainViewController {
    
    private func loadAllEventsFromServer() {
        
        EventClient.loadEvents { (events, error) in
            if let events = events {
                
                let (_, changed, added, removed) = Event.syncLocalDBCollection(local: self.eventList.events, fromServer: events)
                
                //Sync events loaded with the local ones
                self.eventList.insertEvents(added, withRowAnimation: .Left, completionHandler: { 
                    self.eventList.removeEvents(removed, withRowAnimation: .Right, completionHandler: {
                        self.eventList.reloadEvents(changed, withRowAnimation: .Fade)
                    })
                })
                
                Event.saveAll()
                
                self.actionBtn.enabled = true
                self.helpBtn.enabled = true
                
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription, maskType: .Gradient)
                
                //TODO: if no internet connection, implement a try again btn.
            }
        }
    }
    
    private func checkHashtag(hashtag: String, availableBlock: Void -> Void, unavailableBlock: Void -> Void) {
        
        SVProgressHUD.showWithStatus(NSLocalizedString("checking", comment: "Loading message from hud"), maskType: .Gradient)
        EventClient.checkHashtag(hashtag, responseBlock: { (available, error) -> Void in
            if let available = available {
                available ? availableBlock() : unavailableBlock()
            }
            else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription, maskType: .Gradient)
            }
        })
    }
    
    private func followHashtag(hashtag: String?) {
        
        let (valid, errorMsg) = FollowEventPopup.validEventForm(hashtag: hashtag)
        if !valid {
            SVProgressHUD.showErrorWithStatus(errorMsg, maskType: .Gradient)
            return
        }
        
        //already safe here, but using guard just to avoid the additional if let or forced unwrap
        guard let hashtag = hashtag else {return}
        
        self.checkHashtag(hashtag,
            availableBlock:  {
                SVProgressHUD.showErrorWithStatus(NSLocalizedString("not_exists", comment: "Tried to follow hashtag that does not exist"), maskType: .Gradient)
            },
            unavailableBlock: {
                EventClient.followEvent(hashtag, responseBlock: { (event, error) -> Void in
                    if let event = event {
                        event.save()
                        self.eventList.insertEvent(event, withRowAnimation: .Left)
                        SVProgressHUD.dismiss()
                    }
                    else {
                        SVProgressHUD.showErrorWithStatus(error?.localizedFailureReason, maskType: .Gradient)
                    }
                    
                    self.aPopupContainer?.close()
                })
        })
    }
    
    private func unfollowEvent(event: Event) {
        
        let alert = UIAlertController(
            title: NSLocalizedString("delete_confirm_title", comment: "Confirm delete alert title"),
            message: NSLocalizedString("delete_confirm_msg", comment: "Confirm delete alert message"),
            preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Button title"), style: .Cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: "Button title"), style: .Default, handler: { (alert) -> Void in
            SVProgressHUD.showWithStatus(NSLocalizedString("unfollowing", comment: "Unfollowing message on loading hud"), maskType: .Gradient)
            EventClient.unfollowEvent(event) { (_, error) in
                
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: .Gradient)
                } else {
                    self.eventList.removeEvent(event, withRowAnimation: .Right)
                    SVProgressHUD.dismiss()
                }
            }
        }))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func createEvent(eventName: String?, hashtag: String?) {
        let (valid, errorMsg) = NewEventPopup.validEventForm(eventName: eventName, hashtag: hashtag)
        if !valid {
            SVProgressHUD.showErrorWithStatus(errorMsg, maskType: .Gradient)
            return
        }
        
        //already safe here, but using guard just to avoid the additional if let or forced unwrap
        guard let eventName = eventName, hashtag = hashtag else {return}
        
        //TODO: refactor this, to create the event in advance, insert it in eventList and then send to server. If returns ok, save it. Destroy it otherwise.
        SVProgressHUD.showWithStatus(NSLocalizedString("creating_event", comment: "Creating message on loading hud"), maskType: .Gradient)
        EventClient.createEvent(eventName, withHashtag: hashtag) { (event, error) -> Void in
            if let event = event {
                event.save()
                self.eventList.insertEvent(event, withRowAnimation: .Left)
                SVProgressHUD.dismiss()
            }
            else {
                SVProgressHUD.showErrorWithStatus(error?.localizedFailureReason, maskType: .Gradient)
            }
            
            self.aPopupContainer?.close()
        }
    }
    
    
    private func deleteEvent(event: Event) {
        let alert = UIAlertController(
            title: NSLocalizedString("delete_confirm_title", comment: "Confirm delete alert title"),
            message: NSLocalizedString("delete_confirm_msg", comment: "Confirm delete alert message"),
            preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Button title"), style: .Cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: "Button title"), style: .Default, handler: { (alert) -> Void in
            SVProgressHUD.showWithStatus(NSLocalizedString("deleting_event", comment: "Deleting event message on loading hud"), maskType: .Gradient)
            EventClient.deleteEvent(event) { (_, error) in
                
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: .Gradient)
                } else {
                    self.eventList.removeEvent(event, withRowAnimation: .Right)
                    SVProgressHUD.dismiss()
                }
            }
            
        }))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func changeStatus(status: Bool, forEvent event: Event) {
        event.status = status
        event.save()
        
        EventClient.updateStatusOfEvent(event, responseBlock: { (_, error) in
            if let error = error {
                SVProgressHUD.showErrorWithStatus(error.localizedFailureReason, maskType: .Gradient)
            }
        })
    }
    
}
