//
//  ViewController.h
//  TestarTextField
//
//  Created by bepid on 03/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *stpEscolher;
@property (weak, nonatomic) IBOutlet UITextField *tfTeste;
@property (weak, nonatomic) IBOutlet UITextField *tfTeste2;

- (IBAction)stpEscolher:(UISegmentedControl *)sender;

@end
