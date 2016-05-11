//
//  GameViewController.m
//  FindColor
//
//  Created by João Marcelo Oliveira de Souza, Davi Cabral de Oliveira, Diego do Carmo Vidal on 07/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import "GameViewController.h"
#import "GameOverViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

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
    
    _red2 = _green2 = _blue2 = 1;
    [self updateBackground2];
    [self changeBackground1];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:)  userInfo:nil repeats:YES];
    
//    self.mSliderRed.transform = CGAffineTransformRotate(self.mSliderRed.transform, 270.0/180 * M_PI);
//    self.mSliderGreen.transform = CGAffineTransformRotate(self.mSliderGreen.transform, 270.0/180 * M_PI);
//    self.mSliderBlue.transform = CGAffineTransformRotate(self.mSliderBlue.transform, 270.0/180 * M_PI);
    
//    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
//    self.mSliderRed.transform = trans;
//    self.mSliderGreen.transform = trans;
//    self.mSliderBlue.transform = trans;
    
    self.count = 30;
    self.mLabelTempo.text = [NSString stringWithFormat:@"%d", self.count];
}

-(void)timerFireMethod:(NSTimer *)timer
{
    if(self.count == 0)
    {
        [self.timer invalidate];
        [self alertarTempo];
        
    }
    else
    {
        self.count--;
    }
}

- (void) alertarAcerto {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Acertou!" message:nil delegate:self cancelButtonTitle:@"Continuar" otherButtonTitles:nil, nil];
    alertview.tag = 0;
    [alertview show];
}

- (void) alertarTempo {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"O tempo acabou!" message:nil delegate:self cancelButtonTitle:@"Continuar" otherButtonTitles:nil, nil];
    alertview.tag = 1;
    [alertview show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChangeSlider:(UISlider *)sender {
    switch (sender.tag) {
        case 0:
            _red2 = sender.value;
            break;
            
        case 1:
            _green2 = sender.value;
            break;
            
        case 2:
            _blue2 = sender.value;
            break;
            
        default:
            break;
    }
    
    [self updateBackground2];
    
    if ([self conferirCoresComRange:0.06]) {
        //self.pontuacao += _count;
        [self setPontuacao:_count];
        [self.timer invalidate];
        [self alertarAcerto];
    }
    
}

-(void)changeBackground1 {
    _red1 = (float)(arc4random() % 256) / 255;
    _green1 = (float)(arc4random() % 256) / 255;
    _blue1 = (float)(arc4random() % 256) / 255;
    
    _mViewBackground1.backgroundColor = [UIColor colorWithRed:_red1 green:_green1 blue:_blue1 alpha:1];
}

-(void)updateBackground2 {
    _mViewBackground2.backgroundColor = [UIColor colorWithRed:_red2 green:_green2 blue:_blue2 alpha:1];
}

- (void) reiniciarSliders {
    _mSliderRed.value = _red2 = 1;
    _mSliderGreen.value = _green2 = 1;
    _mSliderBlue.value = _blue2 = 1;
    [self updateBackground2];
}

- (void)setCount:(int)count
{
    _count = count;
    self.mLabelTempo.text = [NSString stringWithFormat:@"%d", self.count];
}

- (void)setPontuacao:(int)pontos
{
    _pontuacao += pontos;
    self.mLabelPontuacao.text = [NSString stringWithFormat:@"%d", self.pontuacao];
}

-(BOOL) conferirCoresComRange: (float)r
{
    if(_red1 >= _red2 - r && _red1 <= _red2 + r &&
       _green1 >= _green2 - r && _green1 <= _green2 + r &&
       _blue1 >= _blue2 - r && _blue1 <= _blue2 + r)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark AlertView

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        // Se for a AlertView de acerto...
        self.count = 30;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:)  userInfo:nil repeats:YES];
        [self changeBackground1];
        [self reiniciarSliders];
    } else {
        // Se for a AlertView de erro...
        //GameOverViewController *viewController = [[GameOverViewController alloc] init];
        //[self.navigationController pushViewController:viewController animated:YES];
        //self.view = viewController.mViewGameOver;
        GameOverViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TesteID"];
        viewController.pontuacao = _pontuacao;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //GameOverViewController *gameOverView = [segue destinationViewController];
    //gameOverView.pontuacao = _pontuacao;
}


@end
