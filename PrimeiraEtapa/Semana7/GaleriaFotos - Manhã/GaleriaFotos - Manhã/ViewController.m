//
//  ViewController.m
//  GaleriaFotos - Manhã
//
//  Created by bepid on 25/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "Celula.h"
#import "Pessoa.h"
#import "ViewControllerAdd.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mCollection.delegate = self;
    self.mCollection.dataSource = self;
    
    if (_photos == nil) {
        _photos = [NSMutableArray new];
    }
    
    if (_listaPhotos == nil) {
        _listaPhotos = [[NSMutableDictionary alloc] init];
    }

    
    Pessoa * p1 = [[Pessoa alloc] initWihtImagem:@"principe.jpg" andDescricao:@"dhffhfhhfhf" andData:[NSDate date]];
    [_photos addObject:p1];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _photos.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Celula * c = [self.mCollection dequeueReusableCellWithReuseIdentifier:@"celula" forIndexPath:indexPath];
    Pessoa * aux = [_photos objectAtIndex:indexPath.row];
    c.imagem.image = aux.imagem;
    return c;
}

- (IBAction)addPhoto:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"segueAdd" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewControllerAdd * add = segue.destinationViewController;
    add.viewUm = self;
}

-(void)viewDidAppear:(BOOL)animated {
    for (int i = 0; i < _photos.count; i++) {
        [_listaPhotos setObject:_photos forKey:[[_photos objectAtIndex:i] data]];
    }
    
    NSLog(@"%@, %d", [_listaPhotos allKeys], _listaPhotos.count);
    NSLog(@"%@, %d", [_photos description], _photos.count);
}
@end
