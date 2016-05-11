//
//  ViewController.h
//  GestureChallenge
//
//  Created by Diego Vidal on 09/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *mTapFast;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *mDoubleTap;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *mPressTap;

@property (weak, nonatomic) IBOutlet UIView *quadrado;
@property (weak, nonatomic) IBOutlet UIView *click;

- (IBAction)fastTap:(UITapGestureRecognizer *)sender;
- (IBAction)doubleTap:(UITapGestureRecognizer *)sender;
- (IBAction)pressTap:(UILongPressGestureRecognizer *)sender;

@end

