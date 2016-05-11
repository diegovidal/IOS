//
//  ViewController2.m
//  TestarTextField
//
//  Created by bepid on 03/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
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

    //ViewController vc2 = [[ViewController alloc] init];
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

- (IBAction)selecionaCor:(UISegmentedControl *)sender {
    NSInteger index = [sender selectedSegmentIndex];
    if(index == 0)
        self.view.backgroundColor = [UIColor greenColor];
    else
        self.view.backgroundColor = [UIColor yellowColor];
}
@end
