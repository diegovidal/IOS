//
//  GameOverViewController.h
//  FindColor
//
//  Created by bepid on 07/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mLabelPontuacao;
@property (nonatomic) int pontuacao;
@property (strong, nonatomic) IBOutlet UIView *mViewGameOver;

@end
