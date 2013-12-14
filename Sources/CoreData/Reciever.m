//
//  Reciever.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "Reciever.h"
#import "DBCoreDataManager.h"
#import "DBConstants.h"


@implementation Reciever

@dynamic companyID;
@dynamic name;
@dynamic phone;
@dynamic account;
@dynamic adress;
@dynamic archived;

    
- (NSArray *)ordersWithReciever
{
    NSArray *allOrders = [DBCoreDataManager.sharedManager ordersSortedWithKey:kSortOrderKeyDate
                                                                    ascending:YES
                                                          includeActiveOrders:YES
                                                        includeArchivedOrders:YES];
    NSArray *orders = [allOrders filteredArrayUsingPredicate:
                               [NSPredicate predicateWithBlock:^BOOL(Order *anObject, NSDictionary *bindings)
                                {
                                    return [anObject.reciever.companyID isEqualToString:self.companyID];
                                }]];
    return orders;
}

- (BOOL)useInOrders
{
    return self.ordersWithReciever.count > 0;
}
    
@end
