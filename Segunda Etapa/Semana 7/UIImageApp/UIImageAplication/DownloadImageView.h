//
//  DownloadImageView.h
//  UIImageAplication
//
//  Created by Francisco Junior on 09/02/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageView : UIImageView {
    
    NSString *url;
    UIActivityIndicatorView *progress;
    NSOperationQueue *queue;
}

@property (nonatomic, copy) NSString *url;

-(void) downloadImg;


@end
