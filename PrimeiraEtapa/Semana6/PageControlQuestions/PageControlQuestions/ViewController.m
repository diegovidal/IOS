//
//  ViewController.m
//  PageControlQuestions
//
//  Created by bepid on 18/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "Pergunta.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mScrollView.delegate = self;
    
    // Declaração dos objetos perguntas
    Pergunta* p1 = [[Pergunta alloc] initWithPergunta:@" Você tem dificuldade de se localizar na cidade?" andImage:[UIImage imageNamed:@"pergunta_1.jpg"] andReposta:YES];
    
    Pergunta* p2 = [[Pergunta alloc] initWithPergunta:@"Você utiliza tecnologia 3g ou 4g com frequência?" andImage:[UIImage imageNamed:@"pergunta_2.jpg"] andReposta:YES];
    
    Pergunta* p3 = [[Pergunta alloc] initWithPergunta:@"Você utiliza o gps com frequência?" andImage:[UIImage imageNamed:@"pergunta_3.jpg"] andReposta:YES];
    
    Pergunta* p4 = [[Pergunta alloc] initWithPergunta:@"Você tem costume de sair em grupo de pessoas?" andImage:[UIImage imageNamed:@"pergunta_4.jpg"] andReposta:YES];
    
    Pergunta* p5 = [[Pergunta alloc] initWithPergunta:@"Você ja se perdeu de seus amigos?" andImage:[UIImage imageNamed:@"pergunta_5.jpg"] andReposta:YES];
    
    //xxxxxxxxxxxxxxxxxxxx
    
    _respCorretas = 0;
    
    _pageAnterior = 0;
    
    _mLabelRespoCorretas.text = [NSString stringWithFormat:@"%d Pontos", _respCorretas];
    
    _perguntas = [NSArray arrayWithObjects:p1,p2,p3,p4,p5, nil];
    
    self.mPageControl.numberOfPages = _perguntas.count+1;
    self.mPageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.mPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    
    for (int i = 0; i < _perguntas.count; i++) {
        Pergunta * aux = [_perguntas objectAtIndex:i];
        
        CGRect frame;
        
        frame.origin.x = self.mScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.mScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        UILabel* mPergunta = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 60)];
        mPergunta.numberOfLines = 2;
        mPergunta.textAlignment = 1;
        mPergunta.text = aux.pergunta;
        
        UIImageView* mImg = [[UIImageView alloc]initWithFrame:CGRectMake(22, 105, 280, 252)];
        mImg.image = aux.img;
        
         UISwitch* mSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(132, 415, 51, 31)];
        
        
        UILabel* sim = [[UILabel alloc]initWithFrame:CGRectMake(202, 420, 50, 20)];
        sim.text = @"Sim";
        
        UILabel* nao = [[UILabel alloc]initWithFrame:CGRectMake(82, 420, 50, 20)];
        nao.text = @"Não";
        
        aux.switchResp = mSwitch;
        
        [subview addSubview:mPergunta];
        [subview addSubview:mImg];
        [subview addSubview:mSwitch];
        [subview addSubview:sim];
        [subview addSubview:nao];
        
       // subview.backgroundColor = [colors objectAtIndex:i];
        
       // [subview addSubview:_mPergunta];
        
        [self.mScrollView addSubview:subview];
//        [self.mScrollView addSubview:_mImage];
        
    }
    
    // Cria a ultima pagina
    CGRect frame;
    
    frame.origin.x = self.mScrollView.frame.size.width * 5;
    frame.origin.y = 0;
    frame.size = self.mScrollView.frame.size;
    
    UIView *subview = [[UIView alloc] initWithFrame:frame];
    
    UILabel* mPontos = [[UILabel alloc]initWithFrame:CGRectMake(20, 229, 280, 21)];
    mPontos.numberOfLines = 1;
    mPontos.textAlignment = 1;
    _mLabelRespoCorretas = mPontos;
    //mPontos.text = @"testeeee";
    
    [subview addSubview:mPontos];
    
    
    [self.mScrollView addSubview:subview];
    
    //**************************
    
    self.mScrollView.contentSize = CGSizeMake(self.mScrollView.frame.size.width * (_perguntas.count+1), self.mScrollView.frame.size.height);
    
    //self.mScrollView.contentSize = CGSizeMake(5000,600);

    
    self.mScrollView.pagingEnabled = true;
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePage:(UIPageControl *)sender {
    CGRect frame;
    
    frame.origin.x = self.mScrollView.frame.size.width * self.mPageControl.currentPage; // retorna NSInteger da pagina atual
    
    frame.origin.y = 0;
    
    frame.size = self.mScrollView.frame.size;
    
    
    [self.mScrollView scrollRectToVisible:frame animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.mScrollView.frame.size.width;
    
    int page = floor((self.mScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.mPageControl.currentPage = page;
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if(self.pageAnterior < self.mPageControl.currentPage){
        
    Pergunta * aux = [_perguntas objectAtIndex:(self.mPageControl.currentPage)-1];
    BOOL respostaUsu = aux.switchResp.isOn;
    if(respostaUsu == aux.resposta){
        _respCorretas++;
    }
    NSLog(@"%d", self.mPageControl.currentPage);
    NSLog(@"%d", _respCorretas);
    _mLabelRespoCorretas.text = [NSString stringWithFormat:@"%d Pontos", _respCorretas];
        self.pageAnterior = self.mPageControl.currentPage;
        
    }

}

@end
