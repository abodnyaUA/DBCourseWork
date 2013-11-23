//
//  Plan.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Model;

@interface Plan : NSManagedObject

@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *models;
@end

@interface Plan (CoreDataGeneratedAccessors)

- (void)addModelsObject:(Model *)value;
- (void)removeModelsObject:(Model *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
