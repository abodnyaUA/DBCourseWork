//
//  Order.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "Order.h"


@implementation Order

@dynamic orderId;
@dynamic model;
@dynamic orderDate;
@dynamic reciever;
@dynamic status;

- (NSUInteger)totalPrice
{
    NSUInteger total = 0;
    for (Model *model in self.model)
    {
        total += model.count.integerValue * model.price.integerValue;
    }
    return total;
}

@end
