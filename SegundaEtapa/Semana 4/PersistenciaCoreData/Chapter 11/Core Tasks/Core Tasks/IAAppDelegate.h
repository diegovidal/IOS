//
//  IAAppDelegate.h
//  Core Tasks
//
//  Created by Brendan G. Lim on 8/12/13.
//  Copyright (c) 2013 iOS in Action. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
