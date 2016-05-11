//
//  ViewController.h
//  ImagemUIKit01
//
//  Created by bepid on 05/11/14.
//  Copyright (c) 2014 RamiroSeGarante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UIButton *mButton;

- (IBAction)toggleImage:(id)sender;

@end
