//
//  ViewController5.m
//  TestarTextField
//
//  Created by bepid on 03/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()

@end

@implementation ViewController5

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selecionarBotao:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    
    self.labelCima.text = @"Numero: ";//[NSString stringWithFormat: @"Numero: %d",index];
    self.labelBaixo.text = [sender titleForSegmentAtIndex:index];
    //    if(index==0)
    //    {
    //        self.labelBaixo.text = [NSString stringWithFormat:@"Primeiro"];
    //    }else if(index == 1)
    //    {
    //                self.labelBaixo.text = [NSString stringWithFormat:@"Segundo"];
    //    }else
    //                self.labelBaixo.text = [NSString stringWithFormat:@"Terceiro"];
    //    

}
@end
