//
//  ViewController.m
//  ScrollViewFreezeExercise
//
//  Created by bepid on 18/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    int xCoordenate = 0;
//    int yCoordenate = 0;
//    int widht = 1024;
//    int height = 768;
    
//    UIImageView * img = [[UIImageView alloc] initWithFrame:(CGRectMake(xCoordenate, yCoordenate, widht, height))];
    
    //[_mImage setFrame:(CGRectMake(0, 0, 10, 10))];
    _mImage.image = [UIImage imageNamed:@"landscape.jpg"];
    
//    UIImage *img = [UIImage imageNamed:@"landscape.jpg"];
//    NSLog(@"\n width: %f\n height: %f", img.size.width, img.size.height);

    
    
    
    //img.image = [UIImage imageNamed:@"landscape.jpg"];
    
    self.mScrollView.contentSize = _mImage.intrinsicContentSize;
    
    //[self.mScrollView addSubview:img];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
