//
//  ViewController.h
//  GaleriaFotos - Manhã
//
//  Created by bepid on 25/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollection;
- (IBAction)addPhoto:(UIBarButtonItem *)sender;
@property NSMutableDictionary * listaPhotos;
@property NSMutableArray * photos;

@end
