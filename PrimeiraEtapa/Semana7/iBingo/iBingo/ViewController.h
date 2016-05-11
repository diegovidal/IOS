//
//  ViewController.h
//  iBingo
//
//  Created by bepid on 24/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
- (IBAction)switchs:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *swich_linha;
@property (weak, nonatomic) IBOutlet UISwitch *swich_coluna;
@property (weak, nonatomic) IBOutlet UISwitch *swich_diagonal;
@property (weak, nonatomic) IBOutlet UISwitch *swich_cartela;

@end