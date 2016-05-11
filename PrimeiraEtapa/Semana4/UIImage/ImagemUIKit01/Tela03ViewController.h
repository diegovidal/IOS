//
//  Tela03ViewController.h
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tela03ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *mDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *mDatePicker2;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

- (IBAction)getComparePickers:(UIDatePicker *)sender;


@end
