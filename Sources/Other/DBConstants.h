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
#define kMakeActiveOrderString              NSLocalizedString(@"Make Active", nil)
#define kMoveInArchiveOrderString           NSLocalizedString(@"Archivate", nil)
#define kNavigationBarTitleOrder            NSLocalizedString(@"Order to %@",nil)

#define kAlertDeleteOrderTitle              NSLocalizedString(@"Deleting Order",nil)
#define kAlertDeleteOrderText               NSLocalizedString(@"Do you really want to delete this order?", nil)
#define kAlertButtonDelete                  NSLocalizedString(@"Delete",nil)
#define kAlertButtonCancel                  NSLocalizedString(@"Cancel",nil)

#define kOrderModelNameTableColomn          NSLocalizedString(@"Model name",nil)
#define kOrderModelCountTableColomn         NSLocalizedString(@"Count",nil)
#define kOrderModelPriceTableColomn         NSLocalizedString(@"Total price",nil)

// Storyboard //

#define kStoryboardMainTitle                NSLocalizedString(@"kStoryboardMainTitle",nil)
#define kStoryboardNewOrder                 NSLocalizedString(@"kStoryboardNewOrder",nil)
#define kStoryboardOrderListTitle           NSLocalizedString(@"kStoryboardOrderListTitle",nil)
#define kStoryboardNewReciever              NSLocalizedString(@"kStoryboardNewReciever",nil)
#define kStoryboardRecieversListTitle       NSLocalizedString(@"kStoryboardRecieversListTitle",nil)
#define kStoryboardNewModel                 NSLocalizedString(@"kStoryboardNewModel",nil)
#define kStoryboardModelsListTitle          NSLocalizedString(@"kStoryboardModelsListTitle",nil)

#define kStoryboardMainOrderList            NSLocalizedString(@"kStoryboardMainOrderList",nil)
#define kStoryboardMainRecieverList         NSLocalizedString(@"kStoryboardMainRecieverList",nil)
#define kStoryboardMainModelList            NSLocalizedString(@"kStoryboardMainModelList",nil)
#define kStoryboardMainNewOrder             NSLocalizedString(@"kStoryboardMainNewOrder",nil)

#define kStoryboardAddModelCount            NSLocalizedString(@"Count: ",nil)
#define kStoryboardAddModelPrice            NSLocalizedString(@"Price: ",nil)

#define kStoryboardModelDetailCount         NSLocalizedString(@"Count: ",nil)
#define kStoryboardModelDetailPrice         NSLocalizedString(@"Price: ",nil)
#define kStoryboardModelDetailID            NSLocalizedString(@"Model ID: ",nil)

#define kStoryboardAddRecieverAdress        NSLocalizedString(@"Adress: ",nil)
#define kStoryboardAddRecieverPhone         NSLocalizedString(@"Phone: ",nil)
#define kStoryboardAddRecieverBank          NSLocalizedString(@"Bank account: ",nil)

#define kStoryboardRecieverDetailID         NSLocalizedString(@"Company ID: ",nil)
#define kStoryboardRecieverDetailAdress     NSLocalizedString(@"Adress: ",nil)
#define kStoryboardRecieverDetailPhone      NSLocalizedString(@"Phone: ",nil)
#define kStoryboardRecieverDetailBank       NSLocalizedString(@"Bank account: ",nil)

#define kStoryboardOrderListSortStatus      NSLocalizedString(@"Status",nil)
#define kStoryboardOrderListSortDate        NSLocalizedString(@"Date",nil)
#define kStoryboardOrderListSortPrice       NSLocalizedString(@"Price",nil)
#define kStoryboardOrderListSortReciever    NSLocalizedString(@"Reciever",nil)
#define kStoryboardOrderListLabelSort       NSLocalizedString(@"Sort with ",nil)
#define kStoryboardOrderListShowActive      NSLocalizedString(@"Active",nil)
#define kStoryboardOrderListShowArchived    NSLocalizedString(@"Archived",nil)
#define kStoryboardOrderListLabelShow       NSLocalizedString(@"Status",nil)

#define kStoryboardOrderListCellReciever    NSLocalizedString(@"Reciever:",nil)
#define kStoryboardOrderListCellModels      NSLocalizedString(@"Models:",nil)

#define kStoryboardMakeOrderModels          NSLocalizedString(@"Models: ",nil)
#define kStoryboardMakeOrderReciever        NSLocalizedString(@"Reciever: ",nil)
#define kStoryboardMakeOrderChooseModels    NSLocalizedString(@"Choose...",nil)
#define kStoryboardMakeOrderChooseReciever  NSLocalizedString(@"Choose...",nil)

#define kStoryboardOrderDetailCompany__     NSLocalizedString(@"Company: _________",nil)
#define kStoryboardOrderDetailReciever__    NSLocalizedString(@"Reciever:  ________",nil)
#define kStoryboardOrderDetailTotal         NSLocalizedString(@"Total: ",nil)
#define kStoryboardOrderDetailModels        NSLocalizedString(@"Models:",nil)
#define kStoryboardOrderDetailBank          NSLocalizedString(@"Bank:",nil)
#define kStoryboardOrderDetailPhone         NSLocalizedString(@"Phone:",nil)
#define kStoryboardOrderDetailAdress        NSLocalizedString(@"Adress: ",nil)
#define kStoryboardOrderDetailReciever      NSLocalizedString(@"Reciever:",nil)
#define kStoryboardOrderDetailOrderNumber   NSLocalizedString(@"Order №",nil)







