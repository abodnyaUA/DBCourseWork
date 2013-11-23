//
//  DBModelBought.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBModelBought.h"

@implementation DBModelBought

- (id)initWithModel:(Model *)aModel andCount:(NSUInteger)aCount
{
    self = [super init];
    if (nil != self)
    {
        self.model = aModel;
        self.count = aCount;
    }
    return self;
}

+ (id)boughtWithModel:(Model *)aModel andCount:(NSUInteger)aCount
{
    return [[DBModelBought alloc] initWithModel:aModel andCount:aCount];
}

@end
