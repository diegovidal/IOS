//
//  ViewController.m
//  GuessTheFlag
//
//  Created by bepid on 06/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    srand(time(NULL));
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _mPicker.delegate = self;
    _mPicker.dataSource = self;
    
    // Carrega as bandeiras
    _mFlags = [[NSBundle mainBundle] pathsForResourcesOfType:@".png" inDirectory:nil];
   
    self.sorteados = [NSMutableArray new];
    self.countries = [NSMutableArray new];
    while(self.sorteados.count < 4) {
        NSNumber *sorteio = [[NSNumber alloc] initWithInt:rand() % (_mFlags.count -1)];
        if(![self.sorteados containsObject:sorteio])
        {
            
            [self.countries addObject: [self getCountryAtIndex:[sorteio intValue]]];
            [self.sorteados addObject: sorteio];
        }
    }
    _mDataSource = @[self.countries];
    
    self.correctAnswer = [[NSNumber alloc] initWithInt:rand()%4];
    
    self.currentFlag = _mFlags[[self.sorteados[[self.correctAnswer intValue]] intValue]];
    _mImage.image = [UIImage imageNamed:[self getImageAtIndex:[self.sorteados[[self.correctAnswer intValue]] intValue]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmFlag:(UIBarButtonItem *)sender {
    
    if([self.mPicker selectedRowInComponent:0] == [self.correctAnswer intValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sabe o que isso quer dizer?" message:@"Nada" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
            //_points.text = "20 pontos";
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Errou" message:@"Otário" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    
//
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Você ta sendo testado" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
    
}

-(NSString *)getCountryAtIndex:(int)index
{
    NSString* pais = [_mFlags[index] lastPathComponent];
    pais = [pais stringByReplacingOccurrencesOfString:@".png" withString:@""];
    pais = [pais stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    return pais;
}

-(NSString *)getImageAtIndex:(int)index
{
    NSString* img = [_mFlags[index] lastPathComponent];
    return img;
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
//    NSString* selectedImage = [[_mDataSource objectAtIndex:component] objectAtIndex:row];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[_mDataSource objectAtIndex:component] objectAtIndex:row];
}

#pragma mark - Delegate UiAlertView

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if([self.mPicker selectedRowInComponent:0] == [self.correctAnswer intValue])
    {
        self.sorteados = [NSMutableArray new];
        self.countries = [NSMutableArray new];
        while(self.sorteados.count < 4) {
            NSNumber *sorteio = [[NSNumber alloc] initWithInt:rand() % (_mFlags.count -1)];
            if(![self.sorteados containsObject:sorteio])
            {
                
                [self.countries addObject: [self getCountryAtIndex:[sorteio intValue]]];
                [self.sorteados addObject: sorteio];
            }
        }
        _mDataSource = @[self.countries];
        
        self.correctAnswer = [[NSNumber alloc] initWithInt:rand()%4];
        
        self.currentFlag = _mFlags[[self.sorteados[[self.correctAnswer intValue]] intValue]];
        _mImage.image = [UIImage imageNamed:[self getImageAtIndex:[self.sorteados[[self.correctAnswer intValue]] intValue]]];
        [_mPicker reloadAllComponents];
    }



    
}


@end
