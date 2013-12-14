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

- (NSSet *)recieversInDisplayList;
- (void)setRecieversInDisplayList:(NSSet *)aRecieversList;
- (void)removeRecieverFromDisplayList:(Reciever *)aReciever;
- (void)addRecieverToDisplayList:(Reciever *)aReciever;

- (NSSet *)modelsInDisplayList;
- (void)setModelsInDisplayList:(NSSet *)aModelsList;
- (void)removeModelFromDisplayList:(Model *)aModel;
- (void)addModelToDisplayList:(Model *)aModel;

- (void)setShowArchivedOrders:(BOOL)aFlag;
- (BOOL)showArchivedOrders;
- (void)setShowActiveOrders:(BOOL)aFlag;
- (BOOL)showActiveOrders;

@end
