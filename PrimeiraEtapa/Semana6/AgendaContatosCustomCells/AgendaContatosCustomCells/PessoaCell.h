//
//  PessoaCell.h
//  AgendaContatosCustomCells
//
//  Created by bepid on 20/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PessoaCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *mNome;
@property (nonatomic, weak) IBOutlet UILabel *mTelefone;
@property (nonatomic, weak) IBOutlet UIImageView *mImagem;


@end
