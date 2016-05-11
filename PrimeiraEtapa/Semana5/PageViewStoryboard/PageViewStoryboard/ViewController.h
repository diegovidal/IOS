//
//  ViewController.h
//  PageViewStoryboard
//
//  Created by bepid on 13/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;

- (IBAction)startAction:(UIButton *)sender;


@end
