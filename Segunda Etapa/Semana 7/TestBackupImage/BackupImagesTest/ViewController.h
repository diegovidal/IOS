//
//  ViewController.h
//  BackupImagesTest
//
//  Created by Diego Vidal on 23/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mImage1;
@property (weak, nonatomic) IBOutlet UIImageView *mImage2;
@property (weak, nonatomic) IBOutlet UIImageView *mImage3;

- (IBAction)loadGod:(UIButton *)sender;
- (IBAction)loadImage:(UIButton *)sender;
@end

