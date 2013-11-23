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
#import "Plan.h"
#import "Model.h"


extern NSString * const DBModelWasAddedNotification;
extern NSString * const DBRecieverWasAddedNotification;
extern NSString * const DBOrderWasAddedNotification;

@interface DBCoreDataManager : NSObject

+ (id)sharedManager;

- (NSArray *)accounting;
- (NSArray *)models;
- (NSArray *)recievers;
- (Model *)addModelWithName:(NSString *)name andCost:(NSInteger)cost count:(NSUInteger)aCount;
- (Reciever *)addRecieverWithName:(NSString *)name adress:(NSString *)adress phone:(NSString *)phone account:(NSString *)account;
- (Order *)addOrderWithReciever:(Reciever *)aReciever andModels:(NSArray *)models;
- (void)removeObject:(NSManagedObject *)model;

@end
