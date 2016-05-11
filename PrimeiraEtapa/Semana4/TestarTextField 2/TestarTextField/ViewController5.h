//
//  ViewController5.h
//  TestarTextField
//
//  Created by bepid on 03/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController5 : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelCima;
@property (weak, nonatomic) IBOutlet UILabel *labelBaixo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selecionarBotao;
- (IBAction)selecionarBotao:(UISegmentedControl *)sender;

@end
