//
//  NSUserDefaults+OrderVC.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/30/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSUserDefaults (OrderVC)

- (NSString *)orderFetchSortKey;
- (void)setOrderFetchSortKey:(NSString *)anOrderKey;
- (BOOL)orderFetchAscendingFlag;
- (void)setOrderFetchAscendingFlag:(BOOL)aFlag;

- (void)setShowArchivedOrders:(BOOL)aFlag;
- (BOOL)showArchivedOrders;
- (void)setShowActiveOrders:(BOOL)aFlag;
- (BOOL)showActiveOrders;

@end
