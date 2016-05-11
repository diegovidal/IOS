//
//  IBGesturesViewController.h
//  Gestures - Tap e Long Press
//
//  Created by Jagni Dasa Horta Bezerra on 25/01/15.
//  Copyright (c) 2015 Jagni Dasa Horta Bezerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBGesturesViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *numberTaps;

- (IBAction)tap:(UIGestureRecognizer*)sender;
- (IBAction)longPress:(UIGestureRecognizer*)sender;

@end
