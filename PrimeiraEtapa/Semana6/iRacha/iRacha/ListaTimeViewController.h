//
//  ListaTimeViewController.h
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Time.h"
#import "JogadorViewControllerDelegate.h"
#import "JogadorViewController.h"

@interface ListaTimeViewController : UITableViewController <JogadorViewControllerDelegate>

@property (nonatomic) Time *time;

@end
