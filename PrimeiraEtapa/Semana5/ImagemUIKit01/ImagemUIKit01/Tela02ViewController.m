//
//  Tela02ViewController.m
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import "Tela02ViewController.h"

@interface Tela02ViewController ()

@end

@implementation Tela02ViewController

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
    self.mPicker.delegate = self;
    self.mPicker.dataSource = self;
    
    self.listaBairros = @[@"Benfica", @"Fátima", @"Meireles", @"Bom Jardim", @"Cocó", @"Seis Bocas"];
    self.listaClubes = @[@"Caribe", @"Leblon", @"Terceira Divisão", @"BNB", @"5Shot"];
    self.listaDadosPicker = @[self.listaBairros, self.listaClubes];
    
    [self.mLabelCidade setText:[NSString stringWithFormat:@"Eu moro no %@.", [[self.listaDadosPicker objectAtIndex:0] objectAtIndex:0]]];
    [self.mLabelClube setText:[NSString stringWithFormat:@"Eu me divirto no %@.", [[self.listaDadosPicker objectAtIndex:1] objectAtIndex:0]]];
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

#pragma mark - DataSource

// Retorna o número de colunas do PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.listaDadosPicker.count;
}

// Retorna o número de linhas em uma coluna do PickerView
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self.listaDadosPicker objectAtIndex:component] count];
}

#pragma mark - Delegate

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.listaDadosPicker objectAtIndex:component] objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [self.mLabelCidade setText:[NSString stringWithFormat:@"Eu moro no %@.", [[self.listaDadosPicker objectAtIndex:component] objectAtIndex:row]]];
    }else{
        [self.mLabelClube setText:[NSString stringWithFormat:@"Eu me divirto no %@.", [[self.listaDadosPicker objectAtIndex:component] objectAtIndex:row]]];
    }
}

@end
