//
//  Model.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "Model.h"
#import "DBCoreDataManager.h"
#import "DBConstants.h"


@implementation Model

@dynamic name;
@dynamic price;
@dynamic modelId;
@dynamic count;
@dynamic archived;

- (NSArray *)ordersWithModel
{
    NSArray *allOrders = [DBCoreDataManager.sharedManager ordersSortedWithKey:kSortOrderKeyDate
                                                                    ascending:YES
                                                          includeActiveOrders:YES
                                                        includeArchivedOrders:YES];
    NSArray *orders = [allOrders filteredArrayUsingPredicate:
                       [NSPredicate predicateWithBlock:^BOOL(Order *anObject, NSDictionary *bindings)
                        {
                            for (Model *model in anObject.model) {
                                if ([model.modelId isEqualToString:self.modelId])
                                {
                                    return YES;
                                }
                            }
                            return NO;
                           
                        }]];
    return orders;
}

- (BOOL)useInOrders
{
    return self.ordersWithModel.count > 0;
}

@end
