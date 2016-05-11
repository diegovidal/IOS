//
//  ViewController2.m
//  SliderRGB
//
//  Created by bepid on 04/11/14.
//  Copyright (c) 2014 ifce. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SliderColor:(UISlider *)sender{
    if(sender.tag == 1){
        self.r = sender.value;
        self.view.backgroundColor = [UIColor redColor];
    }else if(sender.tag == 2){
        self.g = sender.value;
        self.view.backgroundColor = [UIColor greenColor];

    }else{
        self.b = sender.value;
        self.view.backgroundColor = [UIColor blueColor];
    }
}

@end
