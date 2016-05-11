//
//  ViewController.m
//  UIImageAplication
//
//  Created by Francisco Junior on 09/02/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "download.h"
#import "DownloadImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet download *downloadImage;
@property (weak, nonatomic) IBOutlet download *downloadImage2;
@property (weak, nonatomic) IBOutlet download * downloadImage3;

@property (nonatomic) UIImage *image1;



@end

@implementation ViewController

static BOOL load;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (load) {
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        UIImage * imageFromWeb = [self loadImage:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];
        _downloadImage.image = imageFromWeb;
        _downloadImage2.image = [self loadImage:@"My Image2" ofType:@"png" inDirectory:documentsDirectoryPath];
        _downloadImage3.image = [self loadImage:@"MyImage3" ofType:@"jpg" inDirectory:documentsDirectoryPath];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Methods
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {

    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
    
}

-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    return result;
}

// IBActions - Buttons
- (IBAction)loadImages:(UIButton *)sender
{
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (!load) {
        _image1 = [self getImageFromURL:@"http://logok.org/wp-content/uploads/2014/04/Apple-Logo-black.png"];
        _downloadImage.image = _image1;
        [self saveImage:_image1 withFileName:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];
        
        _downloadImage2.image = [self getImageFromURL:@"http://www.mobilebeat.com/wp-content/uploads/2013/04/I_heavily_serifed.png"];
        [self saveImage:_downloadImage2.image withFileName:@"My Image2" ofType:@"png" inDirectory:documentsDirectoryPath];
    }
    
    load = YES;
}
- (IBAction)loadGod:(UIButton *)sender {
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    _downloadImage3.image = [self getImageFromURL:@"http://famososnaweb.com/wp-content/uploads/2015/01/SteveJobs-Wide.jpg"];
    [self saveImage:_downloadImage3.image withFileName:@"MyImage3" ofType:@"jpg" inDirectory:documentsDirectoryPath];
}
@end
