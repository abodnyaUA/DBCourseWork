//
//  DBCoreDataManager.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Order.h"
#import "Reciever.h"
#import "Model.h"
#import "Warhouse.h"


extern NSString * const DBModelWasAddedNotification;
extern NSString * const DBRecieverWasAddedNotification;
extern NSString * const DBOrderWasAddedNotification;
extern NSString * const DBYearPlanWasAddedNotification;

@interface DBCoreDataManager : NSObject

+ (id)sharedManager;
- (void)removeObject:(NSManagedObject *)model;

- (NSArray *)modelsOnWarhouse;
- (Model *)addModelToWarhouseWithName:(NSString *)name andCost:(NSInteger)cost count:(NSUInteger)aCount;

- (NSArray *)recievers;
- (Reciever *)addRecieverWithName:(NSString *)name adress:(NSString *)adress phone:(NSString *)phone account:(NSString *)account;

- (NSArray *)ordersSortedWithKey:(NSString *)aKey
                       ascending:(BOOL)anAscending
             includeActiveOrders:(BOOL)anActiveFlag
           includeArchivedOrders:(BOOL)anArchivedFlag;
- (Order *)addOrderWithReciever:(Reciever *)aReciever andModels:(NSArray *)models;
- (Model *)retainModel:(Model *)aModel withCount:(NSUInteger)aCount;

@end
