//
//  DownloadImageView.m
//  gameThrough
//
//  Created by bepid on 02/12/14.
//  Copyright (c) 2014 BEPiD IFCE. All rights reserved.
//

#import "download.h"


@implementation download

@synthesize url;


#define LOG_ON YES
#define CACHE_ON YES

#pragma mark ciclo de vida

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        
        
        progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:progress];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // inicializa no centro
    progress.center = [self convertPoint:self.center fromView:self.superview];
}

-(void)setUrl:(NSString *)urlParam
{
    if ([urlParam length] == 0) {
        url = nil;
        self.image = nil;
    }
    else if (urlParam != self.url){
        url = [urlParam copy];
        self.image = nil;
        if (!queue) {
            queue = [NSOperationQueue new];
        }
        
        [queue cancelAllOperations];
        
        // Animacao Activity
        
        [progress startAnimating];
        
        // Inicia o download em uma NSOperation
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImg) object:nil];
        [queue addOperation:operation];
    }
}


#pragma mark download Background

-(void) downloadImg
{
    NSString *file = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"_"];
    file = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"_"];
    file = [url stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    file = [@"/Documents/" stringByAppendingString:file];
    file = [NSHomeDirectory() stringByAppendingString:[NSString stringWithString:file]];
    
    
    
    if (LOG_ON && CACHE_ON) {
        NSLog(@"Arquivo imagem %@", file);
    }
    
    if (CACHE_ON && [[NSFileManager defaultManager] fileExistsAtPath:file]) {
        
        //Lê a imagem do cache
        NSData *data = [NSData dataWithContentsOfFile:file];
        if (data) {
            if (LOG_ON) {
                NSLog(@"Encontrada na cache");
            }
            UIImage *imagem = [UIImage imageWithData:data];
            
            // Atualiza a imagemView na MainThread
            [self performSelectorOnMainThread:@selector(showImg:) withObject:imagem waitUntilDone:YES];
        }
    }
    if (LOG_ON) {
        NSLog(@"Download com url: %@", url);
    }
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *imagemGame = [UIImage imageWithData:data];
    
    //Salvando no Cache
    if (CACHE_ON) {
        // Salvo no cache
        [data writeToFile:file atomically:YES];
    }
    
    // Atualiza o UIImageView com a imagem carregada no cache
    [self performSelectorOnMainThread:@selector(showImg:) withObject:imagemGame waitUntilDone:YES];
    
}

// Atualiza Imagem

-(void)showImg: (UIImage *) imagem
{
    
    self.image = imagem;
    [progress stopAnimating];
}


@end
