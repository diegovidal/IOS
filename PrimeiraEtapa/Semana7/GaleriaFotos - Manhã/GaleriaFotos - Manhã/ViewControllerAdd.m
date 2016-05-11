//
//  ViewControllerAdd.m
//  GaleriaFotos - Manhã
//
//  Created by bepid on 25/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerAdd.h"

@interface ViewControllerAdd ()

@end

@implementation ViewControllerAdd

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
    self.textDescricao.delegate = self;
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

- (IBAction)btnDone:(UIBarButtonItem *)sender {
    NSString * descricao = _textDescricao.text;
    NSString * txtData = _textDate.text;
    NSDateFormatter * formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"dd-MM-yyyy"];
    NSDate * data = [[NSDate alloc] init];
    data = [formate dateFromString:txtData];
    Pessoa * p = [[Pessoa alloc] initWihtImagem:@"principe.jpg" andDescricao:descricao andData:data];
    
    [_viewUm.photos addObject:p];
    [_viewUm.mCollection reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)datePicker:(UIDatePicker *)sender {
    NSDateFormatter * formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"dd-MM-yyyy"];
    
    self.textDate.text = [NSString stringWithFormat:@"%@",[formate stringFromDate:sender.date]];
}

- (IBAction)cadastroBack:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textDescricao endEditing:YES];
}

@end
