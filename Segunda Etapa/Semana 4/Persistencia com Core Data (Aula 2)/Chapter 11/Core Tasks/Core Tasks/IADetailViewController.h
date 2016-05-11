//
//  IADetailViewController.h
//  Core Tasks
//
//  Created by Brendan G. Lim on 8/12/13.
//  Copyright (c) 2013 iOS in Action. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h> edivando amigo yuri tbm
#import "List.h"

@interface IADetailViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) List *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
