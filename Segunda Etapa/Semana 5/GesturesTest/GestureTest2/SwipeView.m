//
//  FirstViewController.m
//  GestureTest2
//
//  Created by Diego Vidal on 11/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "SwipeView.h"

@interface SwipeView ()

@end

@implementation SwipeView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Uma gesture só pode ter apenas uma view
    UISwipeGestureRecognizer *swipeCentroDireita = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeParaEsquerda:)];
    swipeCentroDireita.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeCentroEsquerda = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeParaDireita:)];
    swipeCentroEsquerda.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeEsquerdaCentro = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeParaEsquerda:)];
    swipeEsquerdaCentro.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeDireitaCentro = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeParaDireita:)];
    swipeDireitaCentro.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer * swipeCentroBaixo = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeParaCima:)];
    swipeCentroBaixo.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer * swipeBaixoCentro = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeParaBaixo:)];
    swipeBaixoCentro.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.esquerdaView addGestureRecognizer:swipeEsquerdaCentro];
    [self.direitaView addGestureRecognizer:swipeDireitaCentro];
    [self.mainView addGestureRecognizer:swipeCentroEsquerda];
    [self.mainView addGestureRecognizer:swipeCentroDireita];
    [self.mainView addGestureRecognizer:swipeCentroBaixo];
    [self.baixoView addGestureRecognizer:swipeBaixoCentro];
}

-(void)swipeParaEsquerda:(UISwipeGestureRecognizer*) swipe{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectOffset(self.mainView.frame, -320.0, 0);
        self.direitaView.frame = CGRectOffset(self.direitaView.frame, -320.0, 0);
        self.esquerdaView.frame = CGRectOffset(self.esquerdaView.frame, -320.0, 0);

    }];

}

-(void)swipeParaDireita:(UISwipeGestureRecognizer*) swipe{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectOffset(self.mainView.frame, 320.0, 0);
        self.direitaView.frame = CGRectOffset(self.direitaView.frame, 320.0, 0);
        self.esquerdaView.frame = CGRectOffset(self.esquerdaView.frame, 320.0, 0);
        
    }];
    
}

-(void)swipeParaCima:(UISwipeGestureRecognizer*) swipe{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectOffset(self.mainView.frame, 0, -568.0);
        self.baixoView.frame = CGRectOffset(self.baixoView.frame, 0, -568.0);
    }];
    
}

-(void)swipeParaBaixo:(UISwipeGestureRecognizer*) swipe{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectOffset(self.mainView.frame, 0, 568.0);
        self.baixoView.frame = CGRectOffset(self.baixoView.frame, 0, 568.0);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
