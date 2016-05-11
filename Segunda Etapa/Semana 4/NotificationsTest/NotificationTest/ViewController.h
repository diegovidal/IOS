//
//  ViewController.h
//  NotificationTest
//
//  Created by Diego Vidal on 06/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *someSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *mensagemSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *badgeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *repetirSwitch;

@property (weak, nonatomic) IBOutlet UIDatePicker *mDataPicker;

- (IBAction)limparBadges:(UIButton *)sender;
- (IBAction)parar:(UIButton *)sender;
- (IBAction)agendar:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *confirmacaoLabel;
@end

