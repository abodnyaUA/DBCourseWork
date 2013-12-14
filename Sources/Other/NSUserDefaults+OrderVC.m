//
//  NSUserDefaults+OrderVC.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/30/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "NSUserDefaults+OrderVC.h"
#import "DBConstants.h"
#import "Reciever.h"
#import "Model.h"


NSString * const kUserDefaultsSortOrderKey  = @"OrderSortKey";
NSString * const kUserDefaultsSortOrderAscendingFlag  = @"OrderSortAscendingFlag";
NSString * const kUserDefaultsShowActiveOrders  = @"ShowActiveOrders";
NSString * const kUserDefaultsShowArchivedOrders  = @"ShowArchivedOrders";

NSString * const kUserDefaultsRecieversInDisplayList  = @"RecieversInDisplayList";
NSString * const kUserDefaultsModelsInDisplayList  = @"ModelsInDisplayList";

@implementation NSUserDefaults (OrderVC)

- (NSString *)orderFetchSortKey
{
    NSString *key = [self valueForKey:kUserDefaultsSortOrderKey];
    if (nil == key)
    {
        [self setValue:kSortOrderKeyDate forKey:kUserDefaultsSortOrderKey];
        key = kSortOrderKeyDate;
    }
    return key;
}

- (void)setOrderFetchSortKey:(NSString *)anOrderKey
{
    NSString *key = [self valueForKey:kUserDefaultsSortOrderKey];
    if ([key isEqualToString:anOrderKey])
    {
        BOOL ascendingFlag = [self orderFetchAscendingFlag];
        [self setOrderFetchAscendingFlag:!ascendingFlag];
    }
    else
    {
        [self setValue:anOrderKey forKey:kUserDefaultsSortOrderKey];
    }
}

- (BOOL)orderFetchAscendingFlag
{
    NSNumber *flag = [self valueForKey:kUserDefaultsSortOrderAscendingFlag];
    if (nil == flag)
    {
        [self setBool:YES forKey:kUserDefaultsSortOrderAscendingFlag];
        return YES;
    }
    return [flag boolValue];
}

- (void)setOrderFetchAscendingFlag:(BOOL)aFlag
{
    [self setBool:aFlag forKey:kUserDefaultsSortOrderAscendingFlag];
}

- (BOOL)showActiveOrders
{
    NSNumber *flag = [self valueForKey:kUserDefaultsShowActiveOrders];
    if (nil == flag)
    {
        [self setBool:YES forKey:kUserDefaultsShowActiveOrders];
        return YES;
    }
    return [flag boolValue];
}

- (void)setShowActiveOrders:(BOOL)aFlag
{
    [self setBool:aFlag forKey:kUserDefaultsShowActiveOrders];    
}

- (BOOL)showArchivedOrders
{
    NSNumber *flag = [self valueForKey:kUserDefaultsShowArchivedOrders];
    if (nil == flag)
    {
        [self setBool:YES forKey:kUserDefaultsShowArchivedOrders];
        return YES;
    }
    return [flag boolValue];
}

- (void)setShowArchivedOrders:(BOOL)aFlag
{
    [self setBool:aFlag forKey:kUserDefaultsShowArchivedOrders];
}

#pragma mark -

- (NSSet *)recieversInDisplayList
{
    NSSet * recievers = [self valueForKey:kUserDefaultsRecieversInDisplayList];
    if (nil == recievers)
    {
        recievers = self.recieversInDisplayList = [NSSet new];
    }
    return recievers;
}

- (void)setRecieversInDisplayList:(NSSet *)aRecieversList
{
    if (nil != aRecieversList)
    {
        [self setValue:aRecieversList forKey:kUserDefaultsRecieversInDisplayList];
    }
}

- (void)removeRecieverFromDisplayList:(Reciever *)aReciever
{
    NSMutableSet *mutable = [self.recieversInDisplayList mutableCopy];
    [mutable removeObject:aReciever.companyID];
    self.recieversInDisplayList = [mutable copy];
}

- (void)addRecieverToDisplayList:(Reciever *)aReciever
{
    NSMutableSet *mutable = [self.recieversInDisplayList mutableCopy];
    [mutable addObject:aReciever.companyID];
    self.recieversInDisplayList = [mutable copy];
}
    
- (BOOL)isRecieverInDisplayList:(Reciever *)aReciever
{
    __block BOOL exist = NO;
    [self.recieversInDisplayList enumerateObjectsUsingBlock:^(Reciever * obj, BOOL *stop)
    {
        if ([obj.companyID isEqualToString:aReciever.companyID])
        {
            exist = YES;
            *stop = YES;
        }
    }];
    return exist;
}

#pragma mark -

- (NSSet *)modelsInDisplayList
{
    NSSet * models = [self valueForKey:kUserDefaultsModelsInDisplayList];
    if (nil == models)
    {
        models = self.modelsInDisplayList = [NSSet new];
    }
    return models;
}

- (void)setModelsInDisplayList:(NSSet *)aModelsList
{
    if (nil != aModelsList)
    {
        [self setValue:aModelsList forKey:kUserDefaultsModelsInDisplayList];
    }
}

- (void)removeModelFromDisplayList:(Model *)aModel
{
    NSMutableSet *mutable = [self.modelsInDisplayList mutableCopy];
    [mutable removeObject:aModel.modelId];
    self.modelsInDisplayList = [mutable copy];
}

- (void)addModelToDisplayList:(Model *)aModel
{
    NSMutableSet *mutable = [self.modelsInDisplayList mutableCopy];
    [mutable addObject:aModel.modelId];
    self.modelsInDisplayList = [mutable copy];    
}
    
- (BOOL)isModelInDisplayList:(Model *)aModel
    {
        __block BOOL exist = NO;
        [self.modelsInDisplayList enumerateObjectsUsingBlock:^(Model * obj, BOOL *stop)
         {
             if ([obj.modelId isEqualToString:aModel.modelId])
             {
                 exist = YES;
                 *stop = YES;
             }
         }];
        return exist;
    }

@end
