//
//  ViewController.h
//  PageControlQuestions
//
//  Created by bepid on 18/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *mPageControl;


@property (nonatomic) int respCorretas;
@property (nonatomic) NSArray* perguntas;
@property (nonatomic) UILabel* mLabelRespoCorretas;
@property (nonatomic) int pageAnterior;

- (IBAction)changePage:(UIPageControl *)sender;

@end
