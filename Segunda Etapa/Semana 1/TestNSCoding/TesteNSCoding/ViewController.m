//
//  ViewController.m
//  TesteNSCoding
//
//  Created by Diego Vidal on 12/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self saveBook];
    [self loadBook];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) saveBook{
    
    Book *b1 = [[Book alloc] init];
    
    b1.title = @"A Estratégia do Oceano Azul";
    b1.author = @"W. Chan Kin & Renée Mauborgne";
    b1.pageCount = 241;
    b1.available = YES;
    
    NSArray *diretorios = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [diretorios lastObject];
    NSString *pathB1 = [documents stringByAppendingString:@"b1.book"];
    
    if ([NSKeyedArchiver archiveRootObject:b1 toFile:pathB1]) {
        NSLog(@"Arquivo gravado com sucesso.");
    }
    else{
        NSLog(@"Falha ao salvar o arquivo.");
    }

}

-(void) loadBook{
    
    NSArray *diretorios = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [diretorios lastObject];
    NSString *pathB1 = [documents stringByAppendingString:@"b1.book"];
    
    Book *b1Restored = [NSKeyedUnarchiver unarchiveObjectWithFile:pathB1];
    
    if (b1Restored != nil) {
        NSLog(@"%@", b1Restored.title);
        NSLog(@"%@", b1Restored.author);
        NSLog(@"%ld", b1Restored.pageCount);
        if(b1Restored.isAvailable){
            NSLog(@"Disponível na biblioteca do BEPiD");
        }
    }
    else{
        NSLog(@"Falha ao ler o arquivo");
    }
    
    
}


@end
