//
//  NSUserDefaults+OrderVC.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/30/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "NSUserDefaults+OrderVC.h"
#import "DBConstants.h"


NSString * const kUserDefaultsSortOrderKey  = @"OrderSortKey";
NSString * const kUserDefaultsSortOrderAscendingFlag  = @"OrderSortAscendingFlag";
NSString * const kUserDefaultsShowActiveOrders  = @"ShowActiveOrders";
NSString * const kUserDefaultsShowArchivedOrders  = @"ShowArchivedOrders";

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

@end
