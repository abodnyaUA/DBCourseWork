//
//  Reciever.h
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reciever : NSManagedObject

@property (nonatomic, retain) NSString * companyID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSString * adress;

@end
