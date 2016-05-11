//
//  ViewController.m
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "MainViewController.h"
#import "ListaTimeViewController.h"
#import "JogarViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.time1 = [Time new];
    self.time2 = [Time new];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SegueTableView"]) {
        
        ListaTimeViewController *lista = segue.destinationViewController;
    
        lista.time = sender;
    }
    else {
        JogarViewController *jogo = segue.destinationViewController;
        jogo.time1 = self.time1;
        jogo.time2 = self.time2;
    }
}

- (IBAction)mostrarLista:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            [self performSegueWithIdentifier:@"SegueTableView" sender:self.time1];
            break;
        case 2:
            [self performSegueWithIdentifier:@"SegueTableView" sender:self.time2];
            break;
    }

}

- (IBAction)iniciarJogo:(UIButton *)sender {
    [self performSegueWithIdentifier: @"segueJogar" sender:nil];
}
@end
