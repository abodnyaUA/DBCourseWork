//
//  DBModelBought.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBCoreDataManager.h"

@interface DBModelBought : NSObject

@property (strong, nonatomic) Model *model;
@property (assign, nonatomic) NSUInteger count;

- (id)initWithModel:(Model *)aModel andCount:(NSUInteger)aCount;
+ (id)boughtWithModel:(Model *)aModel andCount:(NSUInteger)aCount;

@end
