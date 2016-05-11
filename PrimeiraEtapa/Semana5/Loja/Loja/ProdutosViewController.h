//
//  ProdutosViewController.h
//  Loja
//
//  Created by bepid on 11/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProdutosViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


- (IBAction)onTouchButtonAdicionar:(id)sender;

@end
