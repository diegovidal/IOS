//
//  ViewController.m
//  SQliteTeste
//
//  Created by Diego Vidal on 22/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@property sqlite3 *myDataBase;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Criando banco de dados
    const char *path = "/tmp/bepid.bd";
    if(sqlite3_open(path, &_myDataBase) == SQLITE_OK){
        NSLog(@"Banco de dados abriu/foi criado com sucesso");
    
    }
    else {
        NSLog(@"Deu erro ao criar o banco de dados");
    }
    
    // Criando uma tabela
    const char *createTB = "CREATE TABLE alunos (matricula INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT)";
    char *err;
    
    if(sqlite3_exec(_myDataBase, createTB, nil, nil, &err) != SQLITE_OK){
        NSLog(@"Erro ao criar o Banco de Dados %s", err);
    }
    else{
        NSLog(@"Deu tudo certo!");
    }
    
    // Criando uma linha na tabela alunos
    sqlite3_stmt *cursor;
    const char *addAluno = "INSERT INTO alunos (nome) VALUES (\"teste \")";
    sqlite3_prepare_v2(_myDataBase, addAluno, -1, &cursor, nil);
    
    if (sqlite3_step(cursor) == SQLITE_DONE){
        NSLog(@"Aluno inserido com sucesso");
    
    }
    else{
        NSLog(@"Erro ao inserir o aluno");
    }
    
    //Mostrando alunos
    const char *selectAlunos = "SELECT matricula, nome FROM alunos";
    sqlite3_prepare_v2(_myDataBase, selectAlunos, -1, &cursor, nil);
    
    //NSMutableArray *alunos = [[NSMutableArray alloc] init];
    
    while (sqlite3_step(cursor) == SQLITE_ROW) {
        int matricula = sqlite3_column_bytes(cursor, 0);
        NSString *nome = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(cursor, 1)];
        NSLog(@"Nome: %@, Matrícula: %i ", nome, matricula);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
