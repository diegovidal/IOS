//
//  ViewController.m
//  TesteNSHomeDirectory
//
//  Created by Diego Vidal on 12/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self saveFile];
    //[self loadFile];
    [self copyFile];
    
    //[self savePList];
    //[self loadPList];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mostraDocuments{
    NSString *home = NSHomeDirectory();
    NSString *documents = [home stringByAppendingString:@"/Documents"];
    NSLog(@"%@", documents);
}

-(void)mostraDocuments2{
    NSArray *pastas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [pastas lastObject];
    NSLog(@"%@", documents);

}

-(void) saveFile{
    NSArray *pastas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [pastas lastObject];
    NSString *path = [documents stringByAppendingString:@"/texto2.txt"];
    
    NSString *texto = @"Appledhasudashdah";
    
    if([texto writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil]){
        NSString *aux = [NSString stringWithFormat: @"Arquivo Gravado com Sucesso em %@", path];
        NSLog(@"%@", aux);
    }
    else{
        NSLog(@"Erro na Gravação do Arquivo");
    }
}

-(void) loadFile{
    NSArray *pastas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [pastas lastObject];
    NSString *path = [documents stringByAppendingString:@"/texto2.txt"];
    NSString *texto = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if (texto != nil) {
        NSLog(@"Dados Carregados com Sucesso");
        NSLog(@"%@", texto);
    }
    else{
        NSLog(@"Erro");
    }

}

-(void) copyFile{
    
    NSArray *pastas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [pastas lastObject];
    NSString *path1 = [documents stringByAppendingString:@"/texto.txt"];
    NSString *path2 = [documents stringByAppendingString:@"/texto3.txt"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSLog(@"%d",[manager copyItemAtPath:path1 toPath:path2 error:nil]);
    

}

-(void) savePList{
    NSArray *diretorios = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [diretorios lastObject];
    
    NSArray *prof = [[NSArray alloc] initWithObjects:@"Prof1", @"Prof2", @"Prof3", @"Prof4", @"Prof5", nil];
    
    NSString *pathProf = [documents stringByAppendingPathComponent:@"listProf.plist"];
    
    if ([prof writeToFile:pathProf atomically:YES]) {
        NSLog(@"Arquivo plist gravado com sucesso.");
    }
    else{
        NSLog(@"Erro na gracação do arquivo.");
    }

}

-(void) loadPList{
    NSArray *diretorios = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [diretorios lastObject];
    NSString *path = [documents stringByAppendingString:@"/listProf.plist"];
    
     NSArray *texto = [NSArray arrayWithContentsOfFile:path];
    
    if (texto != nil) {
        NSLog(@"Dados Carregados com Sucesso");
        NSLog(@"%@", texto);
    }
    else{
        NSLog(@"Erro");
    }

}
@end
