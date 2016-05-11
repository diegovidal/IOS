//
//  DetailsViewController.h
//  SeiLaVei
//
//  Created by Diego Vidal on 02/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@interface DetailsViewController : UIViewController

- (IBAction)editarContato:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mButton;

@property (weak, nonatomic) IBOutlet UITextField *mNome;
@property (weak, nonatomic) IBOutlet UITextField *mTelefone;

@property (nonatomic) CoreDataHelper *coreDataHelper;
@property (nonatomic) NSString *nome;
@property (nonatomic) NSString *telefone;



@end
