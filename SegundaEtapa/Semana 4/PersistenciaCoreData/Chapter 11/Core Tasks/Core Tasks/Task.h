//
//  Task.h
//  Core Tasks
//
//  Created by Brendan G. Lim on 8/13/13.
//  Copyright (c) 2013 iOS in Action. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSManagedObject *list;

@end
