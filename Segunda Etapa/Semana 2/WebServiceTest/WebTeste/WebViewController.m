//
//  WebViewController.m
//  WebTeste
//
//  Created by Diego Vidal on 20/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@"http://www.ime.usp.br/dcc"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.navegador.scalesPageToFit = YES;
    [self.navegador loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fechar:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)voltar:(UIButton *)sender {
    [self.navegador goBack];
}

- (IBAction)forward:(UIButton *)sender {
    [self.navegador goForward];
}
@end
