//
//  ViewController2.h
//  MudaView
//
//  Created by bepid on 10/11/14.
//  Copyright (c) 2014 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController


@property(nonatomic) NSString* textoRecebido;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

- (IBAction)backButton:(UIButton *)sender;
@end
