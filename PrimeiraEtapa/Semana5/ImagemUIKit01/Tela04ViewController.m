//
//  Tela04ViewController.m
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import "Tela04ViewController.h"

@interface Tela04ViewController ()

@end

@implementation Tela04ViewController

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
    _mPicker.delegate = self;
    _mPicker.dataSource = self;
    
    //NSArray *pngs = [NSBundle inDirectory:@"Images.xcassets"];
    //NSArray *allImages = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"._Images.xcassets" error:NULL];
    
    NSArray *allImages = [[NSBundle mainBundle] pathsForResourcesOfType:@".png" inDirectory:nil];
    
    _mIconList = @[@"Icon-60.png", @"Icon-72.png", @"Icon-76.png"];
    _mDataSource = @[_mIconList];
    
    NSString* selectedIcon = [[_mDataSource objectAtIndex:0] objectAtIndex:0];
    _mImage.image = [UIImage imageNamed:selectedIcon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _mDataSource.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[_mDataSource objectAtIndex:component] count];
}

#pragma mark - Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString* selectedIcon = [[_mDataSource objectAtIndex:component] objectAtIndex:row];
    _mImage.image = [UIImage imageNamed:selectedIcon];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[_mDataSource objectAtIndex:component] objectAtIndex:row];
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

@end
