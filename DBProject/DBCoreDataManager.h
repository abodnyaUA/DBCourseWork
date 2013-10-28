//
//  DBCoreDataManager.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Accounting.h"
#import "Order.h"
#import "Reciever.h"
#import "Plan.h"
#import "Model.h"

@interface DBCoreDataManager : NSObject

- (NSArray *)accounting;
- (NSArray *)models;
- (Model *)addModelWithName:(NSString *)name andCost:(NSInteger)cost;
- (Reciever *)addRecieverWithName:(NSString *)name adress:(NSString *)adress phone:(NSString *)phone account:(NSString *)account;
- (void)removeObject:(NSManagedObject *)model;
@end
