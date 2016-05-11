//
//  ViewController.h
//  PlanoCarroNovo
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mSalario;
@property (weak, nonatomic) IBOutlet UITextField *mContas;
@property (weak, nonatomic) IBOutlet UITextField *mPoupancaMensal;

@property (strong, nonatomic) IBOutlet UISlider *mSliderSalario;
@property (strong, nonatomic) IBOutlet UISlider *mSliderContas;

@property (weak, nonatomic) IBOutlet UIButton *mCarro1;
@property (weak, nonatomic) IBOutlet UIButton *mCarro2;
@property (weak, nonatomic) IBOutlet UIButton *mCarro3;


@property (nonatomic) UIImage *imagemEnviada;
@property (nonatomic) NSString *carroEnviado;
@property (nonatomic) NSString *poupanca;

- (IBAction)mSliderSaldo:(UISlider *)sender;
- (IBAction)escolheCarro:(UIButton *)sender;

-(void) liberaCarro;

@end
