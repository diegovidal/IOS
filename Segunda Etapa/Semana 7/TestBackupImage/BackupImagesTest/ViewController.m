//
//  ViewController.m
//  BackupImagesTest
//
//  Created by Diego Vidal on 23/02/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) BOOL load;

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


- (IBAction)loadGod:(UIButton *)sender {
    
    _mImage3.image = [self getImageFromUrl:@"http://famososnaweb.com/wp-content/uploads/2015/01/SteveJobs-Wide.jpg"];
    
}

- (IBAction)loadImage:(UIButton *)sender {
    
        _mImage1.image = [self getImageFromUrl:@"http://www.mobilebeat.com/wp-content/uploads/2013/04/I_heavily_serifed.png"];
    
        _mImage2.image = [self getImageFromUrl:@"http://logok.org/wp-content/uploads/2014/04/Apple-Logo-black.png"];
}

-(UIImage*) getImageFromUrl: (NSString*) fileurl{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileurl]];
    UIImage *imageResult = [UIImage imageWithData:data];
    
    return imageResult;
    
}

- (UIImage *) loadImage:(NSString *) fileName andType: (NSString *) extension andDirectory:(NSString *) direcPath{
    UIImage *imageResult = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@",direcPath, fileName, extension]];
    return imageResult;
}

-(void) saveImage: (UIImage *) image andFileName: (NSString *) fileImage andType: (NSString *) extension andDirectory:(NSString *) direcPath{

    if ([extension isEqualToString:@"png"]) {
        
        [UIImagePNGRepresentation(image) writeToFile:[direcPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileImage,@"png"]] options:NSAtomicWrite error:nil];
    }
    else if([extension isEqualToString:@"jpg"]){
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[direcPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileImage,@"jpg"]] options:NSAtomicWrite error:nil];
    }
}
@end
