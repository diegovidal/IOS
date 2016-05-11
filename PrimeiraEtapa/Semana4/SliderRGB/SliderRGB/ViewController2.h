//
//  ViewController2.h
//  SliderRGB
//
//  Created by bepid on 04/11/14.
//  Copyright (c) 2014 ifce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController

- (IBAction)SliderColor:(UISlider *)sender;

@property (strong, nonatomic) IBOutlet UITextField *redField;
@property (strong, nonatomic) IBOutlet UITextField *greenField;
@property (strong, nonatomic) IBOutlet UITextField *blueField;

@property float r;
@property float g;
@property float b;

@end

