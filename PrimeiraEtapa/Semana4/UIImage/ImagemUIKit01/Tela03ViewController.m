//
//  Tela03ViewController.m
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import "Tela03ViewController.h"

@interface Tela03ViewController ()

@end

@implementation Tela03ViewController

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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getComparePickers:(UIDatePicker *)sender {
    
    NSComparisonResult result =  [[_mDatePicker date] compare: [_mDatePicker2 date]];
    switch (result) {
        case NSOrderedAscending:
            _mLabel.text = @"A de cima é menor";
            break;
        case NSOrderedDescending:
            _mLabel.text = @"A de cima é maior";
            break;
        default:
            _mLabel.text = @"As datas são iguais";
            break;
    }
}
@end
