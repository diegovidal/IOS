//
//  DownloadImageView.m
//  gameThrough
//
//  Created by bepid on 02/12/14.
//  Copyright (c) 2014 BEPiD IFCE. All rights reserved.
//

#import "DownloadImageView.h"


@implementation DownloadImageView

@synthesize url;

#define LOG_ON YES
#define CACHE_ON YES

#pragma mark ciclo de vida
- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // inicializa no centro
    progress.center = [self convertPoint:self.center fromView:self.superview];
}


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



//Get Image From URL
//UIImage * imageFromURL = [self getImageFromURL:@"http://www.yourdomain.com/yourImage.png"];

//Save Image to Directory
//[self saveImage:imageFromURL withFileName:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];

//Load Image From Directory
//UIImage * imageFromWeb = [self loadImage:@"My Image" ofType:@"png" inDirectory:documentsDirectoryPath];



@end
