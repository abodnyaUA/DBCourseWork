//
//  DBConstants.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/30/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>

// Order Sort Keys //
extern NSString * const kSortOrderKeyDate;
extern NSString * const kSortOrderKeyStatus;
extern NSString * const kSortOrderKeyReciever;
extern NSString * const kSortOrderKeyTotalPrice;

// DataBase changes //
extern NSString * const DBUpdateModelsListNotification;
extern NSString * const DBUpdateRecieversListNotification;
extern NSString * const DBUpdateOrdersListNotification;

// Localized strings //
#define kMakeActiveOrderString      NSLocalizedString(@"Make Active", nil)
#define kMoveInArchiveOrderString   NSLocalizedString(@"Archivate", nil)
#define kNavigationBarTitleOrder    NSLocalizedString(@"Order to %@",nil)

#define kAlertDeleteOrderTitle      NSLocalizedString(@"Deleting Order",nil)
#define kAlertDeleteOrderText       NSLocalizedString(@"Do you really want to delete this order?", nil)
#define kAlertButtonDelete          NSLocalizedString(@"Delete",nil)
#define kAlertButtonCancel          NSLocalizedString(@"Cancel",nil)

#define kOrderModelNameTableColomn  NSLocalizedString(@"Model name",nil)
#define kOrderModelCountTableColomn  NSLocalizedString(@"Count",nil)
#define kOrderModelPriceTableColomn  NSLocalizedString(@"Total price",nil)