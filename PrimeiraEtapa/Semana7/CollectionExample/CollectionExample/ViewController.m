//
//  ViewController.m
//  CollectionExample
//
//  Created by bepid on 24/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recr    eated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *celula = [collectionView dequeueReusableCellWithReuseIdentifier:@"celula" forIndexPath: indexPath];
    celula.mLabel.text = [NSString stringWithFormat:@"{%ld, %ld}", (long) indexPath.section, (long) indexPath.row ];
    return celula;
}



@end
