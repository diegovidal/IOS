//
//  PageContentViewController.h
//  PageViewStoryboard
//
//  Created by bepid on 13/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;

@end
