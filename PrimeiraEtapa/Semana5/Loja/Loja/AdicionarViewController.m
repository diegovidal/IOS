//
//  AdicionarViewController.m
//  Loja
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "AdicionarViewController.h"

@interface AdicionarViewController ()

@end

@implementation AdicionarViewController

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
    self.mLabelNome.text = self.produto.nome;
    self.mImageView.image = [UIImage imageNamed:self.produto.foto];
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

- (IBAction)onTouchStepper:(UIStepper *)sender {
    int qtd = sender.value;
    self.mLabelQuantidade.text = [NSString stringWithFormat:@"%d",qtd];
}

- (IBAction)onTouchButtonOk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
