//
//  Plan.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "Plan.h"
#import "Order.h"


@implementation Plan

@dynamic year;
@dynamic models;
@dynamic author;
@dynamic creationDate;

- (NSUInteger)totalPrice
{
    NSUInteger total = 0;
    for (Model *model in self.models)
    {
        total += model.count.integerValue * model.price.integerValue;
    }
    return total;
}

@end
