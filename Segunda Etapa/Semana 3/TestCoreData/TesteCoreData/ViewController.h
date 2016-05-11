//
//  ViewController.h
//  TesteCoreData
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mNome;
@property (weak, nonatomic) IBOutlet UITextField *mAdress;
@property (weak, nonatomic) IBOutlet UITextField *mPhone;

@property (weak, nonatomic) IBOutlet UILabel *labelFind;

- (IBAction)save:(UIButton *)sender;
- (IBAction)find:(UIButton *)sender;

@end

