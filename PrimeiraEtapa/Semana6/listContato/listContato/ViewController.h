//
//  ViewController.h
//  listContato
//
//  Created by BEPiD on 11/19/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *editar;

- (IBAction)btnEditar:(UIButton *)sender;
@end
