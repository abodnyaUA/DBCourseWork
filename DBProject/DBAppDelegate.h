//
//  DBAppDelegate.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCoreDataManager.h"

@interface DBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DBCoreDataManager *manager;

+ (DBAppDelegate *)sharedInstance;

@end
