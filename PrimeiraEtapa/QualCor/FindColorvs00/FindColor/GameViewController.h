//
//  GameViewController.h
//  FindColor
//
//  Created by bepid on 07/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic) int pontuacao;

@property (nonatomic) float red1;
@property (nonatomic) float green1;
@property (nonatomic) float blue1;

@property (nonatomic) float red2;
@property (nonatomic) float green2;
@property (nonatomic) float blue2;

@property(nonatomic) int count;

@property (weak, nonatomic) IBOutlet UILabel *mLabelPontuacao;
@property (weak, nonatomic) IBOutlet UILabel *mLabelTempo;

@property (weak, nonatomic) IBOutlet UIView *mViewBackground1;
@property (weak, nonatomic) IBOutlet UIView *mViewBackground2;

@property (weak, nonatomic) IBOutlet UISlider *mSliderRed;
@property (weak, nonatomic) IBOutlet UISlider *mSliderGreen;
@property (weak, nonatomic) IBOutlet UISlider *mSliderBlue;

@property NSTimer* timer;

- (void)timerFireMethod:(NSTimer *)timer;

- (IBAction)onChangeSlider:(UISlider *)sender;

- (void) changeBackground1;
- (void) updateBackground2;

@end
