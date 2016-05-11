//
//  Book.h
//  TesteNSCoding
//
//  Created by Diego Vidal on 12/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject <NSCoding>

@property NSString *title;
@property NSString *author;
@property NSInteger pageCount;

@property (getter = isAvailable)
BOOL available;

@end
