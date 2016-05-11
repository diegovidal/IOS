//
//  JogadorViewController.h
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JogadorViewControllerDelegate.h"


@interface JogadorViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mNome;
@property (weak, nonatomic) IBOutlet UITextField *mNumero;
- (IBAction)btAdd:(UIBarButtonItem *)sender;

@property (nonatomic) id<JogadorViewControllerDelegate> delegate;


@end
