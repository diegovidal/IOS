//
//  Time.m
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Time.h"

@implementation Time
- (instancetype)init
{
    self = [super init];
    if (self) {
        _jogadores = [NSMutableArray new];
    }
    return self;
}
@end
