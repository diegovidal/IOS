//
//  ViewController.m
//  WebTeste
//
//  Created by Diego Vidal on 20/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adicionarContato:(UIButton *)sender {
    // Criando a requisição
    NSString *dados = [NSString stringWithFormat:@"http://www.ime.usp.br/~glauber/cgi-bin/BEPiD/insereContato?NOME=%@&FONE=%@", self.nome.text, self.phone.text];
    dados = [self encodeString:dados];
    NSURL *url = [NSURL URLWithString:dados];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
     // Enviando a requisicão
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *resposta = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    // Exibindo Resposta
    NSString *mensagem;
    if(resposta){
        mensagem = [[NSString alloc] initWithData:resposta encoding:NSUTF8StringEncoding];
    }
    else{
        mensagem = @"Deu pau!";
    }
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Cadastro" message:mensagem delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    self.nome.text = @"";
    //NSLog(@"%@", mensagem);
}

- (IBAction)verContatos:(UIButton *)sender {
    // Criando a requisição
    NSString *dados = @"http://www.ime.usp.br/~glauber/cgi-bin/BEPiD/verContatos";
    NSURL *url = [NSURL URLWithString:dados];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Enviando a requisicão
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *resposta = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    // Exibindo Resposta
    NSString *mensagem;
    if(resposta){
        mensagem = [[NSString alloc] initWithData:resposta encoding:NSUTF8StringEncoding];
    }
    else{
        mensagem = @"Deu pau!";
    }
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Cadastro" message:mensagem delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    //self.nome.text = @"";
    //NSLog(@"%@", mensagem);
}

- (IBAction)gerarJSON:(UIButton *)sender {
    
    // Transforma um Dictionary/Array em um JSON
    NSDictionary *dados = @{@"nome": _nome.text,@"fone": _phone.text};
    NSArray *vetor = @[dados, dados];
    
    NSData *JSON = [NSJSONSerialization dataWithJSONObject:vetor options:NSJSONWritingPrettyPrinted error: nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding]);
}

- (IBAction)obterCursos:(UIButton *)sender {
    
    // Criando a sessão
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sessao = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    // Criando a requisição
    NSURL *url = [NSURL URLWithString:@"https://bookapi.bignerdranch.com/private/courses.json"];
    NSURLRequest *requisicao = [NSURLRequest requestWithURL:url];
    
    // Criando uma tarefa
    NSURLSessionDataTask *tarefa = [sessao dataTaskWithRequest:requisicao completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        for (NSDictionary *d in json[@"courses"]) {
            NSLog(@"%@", d);
        }
    }];
    
    [tarefa resume];
    
}

- (NSString*)encodeString:(NSString*)string
{
    NSString *encodedString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",encodedString);
    return encodedString;
}

- (NSString*)decodeString:(NSString*)string
{
    NSString *decodedString = [string stringByRemovingPercentEncoding];
    NSLog(@"%@",decodedString);
    return decodedString;
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{

    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession]; completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}


- (IBAction)calcularFatorial:(UIButton *)sender {
    
    NSString *dados = [NSString stringWithFormat:@"numero=%@", _mNumero.text];
    NSData *postData = [dados dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *tamanho = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    // Crianco Requisição - POST
    NSURL *url = [NSURL URLWithString:@"http://www.ime.usp.br/~glauber/cgi-bin/cec/fatorial"];
    NSMutableURLRequest *requisicao = [NSMutableURLRequest requestWithURL:url];
    
    [requisicao setHTTPMethod:@"POST"];
    [requisicao setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [requisicao setValue:tamanho forHTTPHeaderField:@"Content-Length"];
    [requisicao setHTTPBody:postData];
    
    // Enviando requisição
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *resposta = [NSURLConnection sendSynchronousRequest:requisicao returningResponse:&urlResponse error:&error];
    
    // Exibindo Resposta
    NSString *mensagem;
    if(resposta){
        mensagem = [[NSString alloc] initWithData:resposta encoding:NSASCIIStringEncoding];
    }
    else{
        mensagem = @"Deu pau!";
    }
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Cadastro" message:mensagem delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    
}
@end
