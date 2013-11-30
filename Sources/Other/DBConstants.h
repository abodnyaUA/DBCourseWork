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

/////// Localized strings /////////

// Simple Strings //
#define kMakeActiveOrderString              NSLocalizedString(@"kMakeActiveOrderString", nil)
#define kMoveInArchiveOrderString           NSLocalizedString(@"kMoveInArchiveOrderString", nil)
#define kNavigationBarTitleOrder            NSLocalizedString(@"kNavigationBarTitleOrder",nil)

#define kOrderModelNameTableColomn          NSLocalizedString(@"kOrderModelNameTableColomn",nil)
#define kOrderModelCountTableColomn         NSLocalizedString(@"kOrderModelCountTableColomn",nil)
#define kOrderModelPriceTableColomn         NSLocalizedString(@"kOrderModelPriceTableColomn",nil)

// Alerts //

#define kAlertDeleteOrderTitle              NSLocalizedString(@"kAlertDeleteOrderTitle",nil)
#define kAlertDeleteOrderText               NSLocalizedString(@"kAlertDeleteOrderText", nil)
#define kAlertButtonDelete                  NSLocalizedString(@"kAlertButtonDelete",nil)
#define kAlertButtonCancel                  NSLocalizedString(@"kAlertButtonCancel",nil)

#define kAlertMissedModelsTitle             NSLocalizedString(@"kAlertMissedModelsTitle", nil)
#define kAlertMissedModelsText              NSLocalizedString(@"kAlertMissedModelsText",nil)
#define kAlertMissedRecieverTitle           NSLocalizedString(@"kAlertMissedRecieverTitle", nil)
#define kAlertMissedRecieverText            NSLocalizedString(@"kAlertMissedRecieverText",nil)
#define kAlertFailOrderContinueButton       NSLocalizedString(@"kAlertFailOrderContinueButton",nil)
#define kAlertFailOrderCancelButton         NSLocalizedString(@"kAlertFailOrderCancelButton",nil)

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

#define kStoryboardAddModelCount            NSLocalizedString(@"kStoryboardAddModelCount",nil)
#define kStoryboardAddModelPrice            NSLocalizedString(@"kStoryboardAddModelPrice",nil)
#define kStoryboardAddModelNamePlaceholder  NSLocalizedString(@"kStoryboardAddModelNamePlaceholder",nil)
#define kStoryboardAddModelCountPlaceholder NSLocalizedString(@"kStoryboardAddModelCountPlaceholder",nil)
#define kStoryboardAddModelPricePlaceholder NSLocalizedString(@"kStoryboardAddModelPricePlaceholder",nil)

#define kStoryboardModelDetailCount         NSLocalizedString(@"kStoryboardModelDetailCount",nil)
#define kStoryboardModelDetailPrice         NSLocalizedString(@"kStoryboardModelDetailPrice",nil)
#define kStoryboardModelDetailID            NSLocalizedString(@"kStoryboardModelDetailID",nil)

#define kStoryboardAddRecieverAdress        NSLocalizedString(@"kStoryboardAddRecieverAdress",nil)
#define kStoryboardAddRecieverPhone         NSLocalizedString(@"kStoryboardAddRecieverPhone",nil)
#define kStoryboardAddRecieverBank          NSLocalizedString(@"kStoryboardAddRecieverBank",nil)
#define kStoryboardAddRecieverNamePlaceholder  NSLocalizedString(@"kStoryboardAddRecieverNamePlaceholder",nil)
#define kStoryboardAddRecieverAdressPlaceholder NSLocalizedString(@"kStoryboardAddRecieverAdressPlaceholder",nil)
#define kStoryboardAddRecieverPhonePlaceholder NSLocalizedString(@"kStoryboardAddRecieverPhonePlaceholder",nil)
#define kStoryboardAddRecieverBankPlaceholder NSLocalizedString(@"kStoryboardAddRecieverBankPlaceholder",nil)

#define kStoryboardRecieverDetailID         NSLocalizedString(@"kStoryboardRecieverDetailID",nil)
#define kStoryboardRecieverDetailAdress     NSLocalizedString(@"kStoryboardRecieverDetailAdress",nil)
#define kStoryboardRecieverDetailPhone      NSLocalizedString(@"kStoryboardRecieverDetailPhone",nil)
#define kStoryboardRecieverDetailBank       NSLocalizedString(@"kStoryboardRecieverDetailBank",nil)

#define kStoryboardOrderListSortStatus      NSLocalizedString(@"kStoryboardOrderListSortStatus",nil)
#define kStoryboardOrderListSortDate        NSLocalizedString(@"kStoryboardOrderListSortDate",nil)
#define kStoryboardOrderListSortPrice       NSLocalizedString(@"kStoryboardOrderListSortPrice",nil)
#define kStoryboardOrderListSortReciever    NSLocalizedString(@"kStoryboardOrderListSortReciever",nil)
#define kStoryboardOrderListLabelSort       NSLocalizedString(@"kStoryboardOrderListLabelSort",nil)
#define kStoryboardOrderListShowActive      NSLocalizedString(@"kStoryboardOrderListShowActive",nil)
#define kStoryboardOrderListShowArchived    NSLocalizedString(@"kStoryboardOrderListShowArchived",nil)
#define kStoryboardOrderListLabelShow       NSLocalizedString(@"kStoryboardOrderListLabelShow",nil)

#define kStoryboardOrderListCellReciever    NSLocalizedString(@"kStoryboardOrderListCellReciever",nil)
#define kStoryboardOrderListCellModels      NSLocalizedString(@"kStoryboardOrderListCellModels",nil)
#define kStoryboardOrderListCellArchive     NSLocalizedString(@"kStoryboardOrderListCellArchive", nil)
#define kStoryboardOrderListCellActive      NSLocalizedString(@"kStoryboardOrderListCellActive", nil)

#define kStoryboardMakeOrderModels          NSLocalizedString(@"kStoryboardMakeOrderModels",nil)
#define kStoryboardMakeOrderReciever        NSLocalizedString(@"kStoryboardMakeOrderReciever",nil)
#define kStoryboardMakeOrderChooseModels    NSLocalizedString(@"kStoryboardMakeOrderChooseModels",nil)
#define kStoryboardMakeOrderChooseReciever  NSLocalizedString(@"kStoryboardMakeOrderChooseReciever",nil)

#define kStoryboardOrderDetailCompany__     NSLocalizedString(@"kStoryboardOrderDetailCompany__",nil)
#define kStoryboardOrderDetailReciever__    NSLocalizedString(@"kStoryboardOrderDetailReciever__",nil)
#define kStoryboardOrderDetailTotal         NSLocalizedString(@"kStoryboardOrderDetailTotal",nil)
#define kStoryboardOrderDetailModels        NSLocalizedString(@"kStoryboardOrderDetailModels",nil)
#define kStoryboardOrderDetailBank          NSLocalizedString(@"kStoryboardOrderDetailBank",nil)
#define kStoryboardOrderDetailPhone         NSLocalizedString(@"kStoryboardOrderDetailPhone",nil)
#define kStoryboardOrderDetailAdress        NSLocalizedString(@"kStoryboardOrderDetailAdress",nil)
#define kStoryboardOrderDetailReciever      NSLocalizedString(@"kStoryboardOrderDetailReciever",nil)
#define kStoryboardOrderDetailOrderNumber   NSLocalizedString(@"kStoryboardOrderDetailOrderNumber",nil)







