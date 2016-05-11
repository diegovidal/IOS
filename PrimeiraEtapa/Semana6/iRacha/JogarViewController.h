//
//  JogarViewController.h
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Time.h"

@interface JogarViewController : UIViewController

@property Time *time1;
@property Time *time2;

@property (weak, nonatomic) IBOutlet UILabel *lbGolTime1;
@property (weak, nonatomic) IBOutlet UILabel *lbGolTime2;


- (IBAction)golTime1:(UIButton *)sender;
- (IBAction)golTime2:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labMili;
@property (weak, nonatomic) IBOutlet UILabel *labSec;
@property (weak, nonatomic) IBOutlet UILabel *labMin;


@end
