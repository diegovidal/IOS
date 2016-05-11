//
//  AdicionarViewController.h
//  Loja
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produto.h"

@interface AdicionarViewController : UIViewController

@property (nonatomic) Produto* produto;

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UILabel *mLabelNome;
@property (weak, nonatomic) IBOutlet UILabel *mLabelQuantidade;

- (IBAction)onTouchStepper:(UIStepper *)sender;
- (IBAction)onTouchButtonOk:(id)sender;

@end
