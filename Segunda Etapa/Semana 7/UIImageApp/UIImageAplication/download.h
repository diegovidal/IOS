////
//  DownloadImageView.h
//  gameThrough
//
//  Created by bepid on 02/12/14.
//  Copyright (c) 2014 BEPiD IFCE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface download : UIImageView {
    NSString *url;
    UIActivityIndicatorView *progress;
    NSOperationQueue *queue;
}

@property (nonatomic, copy) NSString *url;

@end
