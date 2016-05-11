//
//  Book.m
//  TesteNSCoding
//
//  Created by Diego Vidal on 12/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "Book.h"

@implementation Book

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _title = [decoder decodeObjectForKey:@"title"];
    _author = [decoder decodeObjectForKey:@"author"];
    _pageCount = [decoder decodeIntegerForKey:@"pageCount"];
    _available = [decoder decodeBoolForKey:@"available"];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_author forKey:@"author"];
    [encoder encodeInteger:_pageCount forKey:@"pageCount"];
    [encoder encodeBool:[self isAvailable] forKey:@"available"];
}

@end
