//
//  Warhouse.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Model;

@interface Warhouse : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *models;

@end

@interface Warhouse (CoreDataGeneratedAccessors)

- (void)addModelsObject:(Model *)value;
- (void)removeModelsObject:(Model *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
