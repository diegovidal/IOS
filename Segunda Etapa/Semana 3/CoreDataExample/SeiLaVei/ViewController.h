//
//  ViewController.h
//  SeiLaVei
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@interface ViewController : UIViewController

@property (nonatomic) CoreDataHelper *coreDataHelper;

- (IBAction)adicionarContato:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *mNome;
@property (weak, nonatomic) IBOutlet UITextField *mTelefone;


@end

