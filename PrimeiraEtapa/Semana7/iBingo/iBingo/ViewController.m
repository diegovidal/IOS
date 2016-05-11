//
//  ViewController.m
//  iBingo
//
//  Created by bepid on 24/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "CellBingo.h"

@interface ViewController ()

@property NSMutableArray * matrix;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _collection.dataSource = self;
    _collection.delegate = self;
    
    _matrix = [NSMutableArray new];
    NSMutableArray *linha1 = [NSMutableArray new];
    NSMutableArray *linha2 = [NSMutableArray new];
    NSMutableArray *linha3 = [NSMutableArray new];
    NSMutableArray *linha4 = [NSMutableArray new];
    NSMutableArray *linha5 = [NSMutableArray new];
    
    [_matrix addObject:linha1];
    [_matrix addObject:linha2];
    [_matrix addObject:linha3];
    [_matrix addObject:linha4];
    [_matrix addObject:linha5];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellBingo * celula = [collectionView dequeueReusableCellWithReuseIdentifier:@"celula" forIndexPath:indexPath];
    
    celula.lbNum.text = [NSString stringWithFormat:@"%ld", (long) indexPath.row];
    
    celula.backgroundColor = [UIColor whiteColor];
    
    [[_matrix objectAtIndex:indexPath.section] addObject:celula];
    
    return  celula;
}

- (IBAction)switchs:(UISwitch *)sender {
    
    if (_swich_cartela.isOn) {
        [_swich_coluna setOn:NO];
        [_swich_diagonal setOn:NO];
        [_swich_linha setOn:NO];
    }

    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * celula = [collectionView cellForItemAtIndexPath:indexPath];
    
    
    if (celula.backgroundColor == [UIColor whiteColor]) {
        celula.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:1];
    }
    else {
        celula.backgroundColor = [UIColor whiteColor];
    }
    

    NSString * message;
    
    if (_swich_cartela.isOn && [self verificaBateuCartela]) {
        NSLog(@"Bateu cartela");
        message = @"Bateu cartela";
        [self alertWithMessage:message];
    }
    
    if (_swich_linha.isOn && [self verificaBateuLinhaWithIndex:indexPath.section]) {
        NSLog(@"Bateu linha %d", indexPath.section+1);
        message = [NSString stringWithFormat:@"Bateu linha %d", indexPath.section+1];
        [self alertWithMessage:message];
    }
    
    if (_swich_coluna.isOn && [self verificaBateuColunaWithIndex:indexPath.row]) {
        NSLog(@"Bateu coluna %d", indexPath.row+1);
        message = [NSString stringWithFormat:@"Bateu coluna %d", indexPath.row+1];
        [self alertWithMessage:message];
    }
    
    if (_swich_diagonal.isOn && [self verificaBateuDiagonalPrincipal]) {
        NSLog(@"Bateu diagonal principal");
        message = @"Bateu diagonal principal";
        [self alertWithMessage:message];
    }

    if (_swich_diagonal.isOn && [self verificaBateuDiagonalSecundaria]) {
        NSLog(@"Bateu diagonal secundaria");
        message = @"Bateu diagonal secundária";
        [self alertWithMessage:message];
    }
    
    
    
}

-(BOOL) verificaBateuLinhaWithIndex:(int) index {
    int count = 0;
    for (int i = 0; i < 5; i++) {
        CellBingo * aux = [[_matrix objectAtIndex:index] objectAtIndex:i];
        if (aux.backgroundColor != [UIColor whiteColor]) {
            count++;
        }
    }
    if (count == 5) {
        return YES;
    }
    return NO;
}

-(BOOL) verificaBateuColunaWithIndex:(int) index {
    int count = 0;
    for (int i = 0; i < 5; i++) {
        CellBingo * aux = [[_matrix objectAtIndex:i] objectAtIndex:index];
        if (aux.backgroundColor != [UIColor whiteColor]) {
            count++;
        }
    }
    if (count == 5) {
        return YES;
    }
    return NO;
}

-(BOOL) verificaBateuDiagonalPrincipal {
    int count = 0;
    int index = 0;
    for (int i = 0; i < 5; i++) {
        CellBingo * aux = [[_matrix objectAtIndex:i] objectAtIndex:index++];
        
        if (aux.backgroundColor != [UIColor whiteColor]) {
            count++;
        }
    }
    if (count == 5) {
        return YES;
    }
    return NO;
}

-(BOOL) verificaBateuDiagonalSecundaria {
    int count = 0;
    int index = 4;
    for (int i = 0; i < 5; i++) {
        CellBingo * aux = [[_matrix objectAtIndex:i] objectAtIndex:index--];
        
        if (aux.backgroundColor != [UIColor whiteColor]) {
            count++;
        }
    }
    if (count == 5) {
        return YES;
    }
    return NO;
}

-(BOOL) verificaBateuCartela {
    int count = 0;
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            CellBingo * aux = [[_matrix objectAtIndex:i] objectAtIndex:j];
            if (aux.backgroundColor != [UIColor whiteColor]) {
                count++;
            }
        }

    }
    if (count == 25) {
        return YES;
    }
    return NO;
}

-(void) alertWithMessage:(NSString *) message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Parabéns" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
