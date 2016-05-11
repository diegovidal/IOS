//
//  IAMasterViewController.h
//  Core Tasks
//
//  Created by Brendan G. Lim on 8/12/13.
//  Copyright (c) 2013 iOS in Action. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface IAMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
