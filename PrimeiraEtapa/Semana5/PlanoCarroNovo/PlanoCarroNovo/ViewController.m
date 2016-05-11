//
//  ViewController.m
//  PlanoCarroNovo
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self liberaCarro];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mSliderSaldo:(UISlider *)sender {
    switch (sender.tag) {
        case 1:
            //NSLog(@"Slider Salario");
            self.mSalario.text = [NSString stringWithFormat:@"R$" "%.2f",self.mSliderSalario.value ];
            break;
        case 2:
            //NSLog(@"Slider Contas");
            self.mContas.text = [NSString stringWithFormat:@"R$" "%.2f",self.mSliderContas.value];
            break;
        default:
            break;
    }
    if(self.mSliderSalario.value > self.mSliderContas.value)
    {
        NSString *rs= @"R$";
        self.poupanca= [NSString stringWithFormat:@"%.2f",(self.mSliderSalario.value - self.mSliderContas.value)*0.3];
        
        self.mPoupancaMensal.text = [NSString stringWithFormat:@"%@ %@",rs,self.poupanca];
    }
    else{
        self.mPoupancaMensal.text = [NSString stringWithFormat:@"R$" "0.00"];
    }
    [self liberaCarro];
    self.mSliderContas.maximumValue = self.mSliderSalario.value;
}

- (IBAction)escolheCarro:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:{
            self.imagemEnviada = [UIImage imageNamed:@"Carrinho_Mao.jpg"];
            self.carroEnviado = @"Carrinho de mao";
            
            break;
        }
        case 2:{
             self.imagemEnviada = [UIImage imageNamed:@"Fusca.jpg"];
            self.carroEnviado = @"Fusca";
            break;
        }
        case 3:{
             self.imagemEnviada = [UIImage imageNamed:@"Camaro.jpg"];
            self.carroEnviado = @"Camaro";
            break;
        }
        default:
            break;
    }
    [self performSegueWithIdentifier:@"mudaTelaCarros" sender:sender];
}

#pragma marks - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"mudaTelaCarros"]){
        ViewController2 *proximatela = segue.destinationViewController;
        proximatela.imagemRecebida = self.imagemEnviada;
        proximatela.carroRecebido = self.carroEnviado;
    }
}

-(void) liberaCarro{
    //int aux = [[NSNumber alloc] initWithInt:self.mPoupancaMensal.text];
    NSInteger aux = [self.poupanca integerValue];
    
    if (aux < 100) {
        self.mCarro1.enabled = false;
        self.mCarro2.enabled = false;
        self.mCarro3.enabled = false;
        self.mCarro1.backgroundColor = [UIColor grayColor];
        self.mCarro2.backgroundColor = [UIColor grayColor];
        self.mCarro3.backgroundColor = [UIColor grayColor];
    }
    if (aux >= 100 && aux<1500){
        self.mCarro1.enabled = true;
        self.mCarro2.enabled = false;
        self.mCarro3.enabled = false;
        self.mCarro1.backgroundColor = [UIColor orangeColor];
        self.mCarro2.backgroundColor = [UIColor grayColor];
        self.mCarro3.backgroundColor = [UIColor grayColor];
    }
    if (aux >= 1500 && aux<3000){
        self.mCarro1.enabled = true;
        self.mCarro2.enabled = true;
        self.mCarro3.enabled = false;
        self.mCarro1.backgroundColor = [UIColor orangeColor];
        self.mCarro2.backgroundColor = [UIColor orangeColor];
        self.mCarro3.backgroundColor = [UIColor grayColor];
        }
    if (aux >= 3000){
        self.mCarro1.enabled = true;
        self.mCarro2.enabled = true;
        self.mCarro3.enabled = true;
        self.mCarro1.backgroundColor = [UIColor orangeColor];
        self.mCarro2.backgroundColor = [UIColor orangeColor];
        self.mCarro3.backgroundColor = [UIColor orangeColor];
    }
    
}

@end
