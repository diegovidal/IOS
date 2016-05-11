//
//  Tela04ViewController.h
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tela04ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) NSArray *mIconList;
@property (nonatomic) NSArray *mDataSource;

@property (weak, nonatomic) IBOutlet UIPickerView *mPicker;
@property (weak, nonatomic) IBOutlet UIImageView *mImage;

@end
