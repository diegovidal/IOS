//
//  ViewController.m
//  NotificationTest
//
//  Created by Diego Vidal on 06/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _confirmacaoLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)limparBadges:(UIButton *)sender {
}

- (IBAction)parar:(UIButton *)sender {
}

- (IBAction)agendar:(UIButton *)sender {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *oldNotications = [app scheduledLocalNotifications];
    
    if (oldNotications.count > 0) {
        [app cancelAllLocalNotifications];
    }
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if (notification) {
        notification.fireDate = [_mDataPicker date];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        
        if (_someSwitch.on) {
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        if(_mensagemSwitch.on){
            notification.alertBody = @"Time to wake up!!";
        }
        if(_badgeSwitch.on){
            notification.applicationIconBadgeNumber = [app applicationIconBadgeNumber]+1;
        }
        if( _repetirSwitch.on){
            notification.repeatInterval = NSCalendarUnitMinute;
        }
        else{
            notification.repeatInterval = 0;
        }
        
        [app scheduleLocalNotification:notification];
    }
}
@end
