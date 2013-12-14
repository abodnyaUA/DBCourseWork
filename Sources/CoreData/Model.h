//
//  Model.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Model : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * modelId;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSNumber * archived;

- (NSArray *)ordersWithModel;
- (BOOL)useInOrders;

@end
