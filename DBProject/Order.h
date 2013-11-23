//
//  Order.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * orderId;
@property (nonatomic, retain) NSSet *model;
@property (nonatomic, retain) NSDate *orderDate;
@property (nonatomic, retain) NSManagedObject *reciever;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addModelObject:(NSManagedObject *)value;
- (void)removeModelObject:(NSManagedObject *)value;
- (void)addModel:(NSSet *)values;
- (void)removeModel:(NSSet *)values;

@end
