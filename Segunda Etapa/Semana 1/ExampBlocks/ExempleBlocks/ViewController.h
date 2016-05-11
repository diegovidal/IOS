//
//  ViewController.h
//  ExempleBlocks
//
//  Created by Diego Vidal on 14/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)leftSlide:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIView *slideView;

- (IBAction)fazAlerta:(UIButton *)sender;

@end

