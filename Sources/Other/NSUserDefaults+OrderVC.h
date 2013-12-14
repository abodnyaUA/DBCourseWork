//
//  NSUserDefaults+OrderVC.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/30/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Reciever;
@class Model;

@interface NSUserDefaults (OrderVC)

- (NSString *)orderFetchSortKey;
- (void)setOrderFetchSortKey:(NSString *)anOrderKey;
- (BOOL)orderFetchAscendingFlag;
- (void)setOrderFetchAscendingFlag:(BOOL)aFlag;

- (NSArray *)recieversInDisplayList;
- (void)setRecieversInDisplayList:(NSArray *)aRecieversList;
- (void)removeRecieverFromDisplayList:(Reciever *)aReciever;
- (void)addRecieverToDisplayList:(Reciever *)aReciever;
- (BOOL)isRecieverInDisplayList:(Reciever *)aReciever;

- (NSArray *)modelsInDisplayList;
- (void)setModelsInDisplayList:(NSArray *)aModelsList;
- (void)removeModelFromDisplayList:(Model *)aModel;
- (void)addModelToDisplayList:(Model *)aModel;
- (BOOL)isModelInDisplayList:(Model *)aModel;

- (void)setShowArchivedOrders:(BOOL)aFlag;
- (BOOL)showArchivedOrders;
- (void)setShowActiveOrders:(BOOL)aFlag;
- (BOOL)showActiveOrders;

@end
