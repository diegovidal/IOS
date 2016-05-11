//
//  ViewController.h
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Time.h"
@interface MainViewController : UIViewController 


@property (nonatomic) Time *time1;
@property (nonatomic) Time *time2;

- (IBAction)mostrarLista:(UIButton *)sender;
- (IBAction)iniciarJogo:(UIButton *)sender;
@end
