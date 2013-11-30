//
//  Order.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model.h"
#import "Reciever.h"


typedef enum {
    OrderInArchive = 0,
    OrderActive = 1
} OrderState;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSNumber *status;
@property (nonatomic, retain) NSString * orderId;
@property (nonatomic, retain) NSDate *orderDate;
@property (nonatomic, retain) NSSet *model;
@property (nonatomic, retain) Reciever *reciever;

- (NSUInteger)totalPrice;

@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addModelObject:(Model *)value;
- (void)removeModelObject:(Model *)value;
- (void)addModel:(NSSet *)values;
- (void)removeModel:(NSSet *)values;

@end
