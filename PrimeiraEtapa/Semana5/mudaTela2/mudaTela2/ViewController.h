//
//  ViewController.h
//  mudaTela2
//
//  Created by bepid on 10/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) UIColor *corSelecionada;

- (IBAction)escolheCor:(UISegmentedControl *)sender;
- (IBAction)mudaTela:(UIButton *)sender;
@end
