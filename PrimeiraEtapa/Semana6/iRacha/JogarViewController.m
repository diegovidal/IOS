//
//  JogarViewController.m
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "JogarViewController.h"

@interface JogarViewController ()

@end

@implementation JogarViewController{
 NSTimer *timer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) methodUpdate{
    if([_labMin.text intValue] ==0 && [_labMili.text intValue] ==0 && [_labSec.text intValue] ==0){
        [timer invalidate];
    }
    if([_labMili.text intValue] == 0){
        _labMili.text = @"99";
       
        
        if([_labSec.text intValue] == 0){
            _labSec.text = @"59";
            _labMin.text = [@([_labMin.text intValue]-1) stringValue];
        }
        else{
             _labSec.text = [@([_labSec.text intValue]-1) stringValue];
        }
    }else{
        _labMili.text = [@([_labMili.text intValue]-1) stringValue];
    }
}

-(void) updateTime{
    //NSDate *time = [NSDate ]
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSTimeInterval intervalo = 1.0/100;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalo target:self selector:@selector(methodUpdate) userInfo:nil repeats:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)golTime1:(UIButton *)sender {

    int gol = [self.lbGolTime1.text intValue];
    gol++;
    self.lbGolTime1.text = [NSString stringWithFormat:@"%d",gol];
    
}

- (IBAction)golTime2:(UIButton *)sender {
    int gol = [self.lbGolTime2.text intValue];
    gol++;
    self.lbGolTime2.text = [NSString stringWithFormat:@"%d",gol];
}
@end
