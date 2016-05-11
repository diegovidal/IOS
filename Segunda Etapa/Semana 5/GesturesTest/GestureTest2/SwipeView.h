//
//  FirstViewController.h
//  GestureTest2
//
//  Created by Diego Vidal on 11/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeView : UIViewController

@property (weak, nonatomic) IBOutlet UIView *direitaView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *esquerdaView;
@property (weak, nonatomic) IBOutlet UIView *baixoView;


@end

