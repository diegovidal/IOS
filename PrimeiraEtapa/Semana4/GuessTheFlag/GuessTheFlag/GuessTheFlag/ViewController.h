//
//  ViewController.h
//  GuessTheFlag
//
//  Created by bepid on 06/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>

@property (nonatomic) NSArray *mFlags;
@property (nonatomic) NSArray *mDataSource;
@property (nonatomic) NSMutableArray* countries;
@property (nonatomic) NSString* currentFlag;
@property (nonatomic) NSNumber* correctAnswer;
@property (nonatomic) NSMutableArray* sorteados;
@property (weak, nonatomic) IBOutlet UILabel *points;

- (IBAction)confirmFlag:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UIPickerView *mPicker;

-(NSString*) getCountryAtIndex:(int) index;

@end
