//
//  Tela02ViewController.h
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tela02ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) NSArray *listaClubes;
@property (nonatomic) NSArray *listaBairros;
@property (nonatomic) NSArray *listaDadosPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *mPicker;
@property (weak, nonatomic) IBOutlet UILabel *mLabelCidade;
@property (weak, nonatomic) IBOutlet UILabel *mLabelClube;

@end
