//
//  DBCoreDataManager.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBCoreDataManager.h"

#import "DBAppDelegate.h"
#import "DBConstants.h"
#import "NSUserDefaults+OrderVC.h"

@interface DBCoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) Warhouse                     *warhouse;

@end

@implementation DBCoreDataManager

- (id)init
{
    self = [super init];
    if (nil != self)
    {
        [self setUpCoreData];
    }
    return self;
}

+ (id)sharedManager
{
    return DBAppDelegate.sharedInstance.manager;
}

#pragma mark - Core Data stack
- (void)setUpCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL * homeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL * DBFolder = [homeURL URLByAppendingPathComponent:@".CoreData"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:DBFolder.path])
    {
        [[NSFileManager defaultManager] createDirectoryAtURL:DBFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSURL *storeURL = [DBFolder URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    id success = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    NSAssert(nil != success, @"Error while settuping Core Data: %@",[error description]);
    
    
    self.managedObjectContext = [NSManagedObjectContext new];
    [self.managedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    [self createWarhouse];
}

- (void)createWarhouse
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Warhouse" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError * error = nil;
    NSArray *warhouseArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (warhouseArray.count != 0)
    {
        self.warhouse = [warhouseArray objectAtIndex:0];
    }
    else
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        self.warhouse = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Warhouse"
                        inManagedObjectContext:context];
        self.warhouse.name = @"Main warhouse";
        [self updateSorce];
    }
}

- (void)updateSorce
{
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
    {
        NSLog( @"Error while updating Persistance Storage: %@", [error localizedDescription]);
    }
}

- (void)removeObject:(NSManagedObject *)model
{
    [self.managedObjectContext deleteObject:model];
    [self updateSorce];
}

#pragma mark - Orders

- (Order *)addOrderWithReciever:(Reciever *)aReciever andModels:(NSArray *)models
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Order *order = [NSEntityDescription
                                     insertNewObjectForEntityForName:@"Order"
                                     inManagedObjectContext:context];
    order.orderId = [[NSUUID UUID] UUIDString];
    order.reciever = aReciever;
    order.orderDate = [NSDate dateWithTimeIntervalSinceNow:0];
    order.status = [NSNumber numberWithInt:OrderActive];
    [order addModel:[NSSet setWithArray:models]];

    [self updateSorce];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBUpdateOrdersListNotification object:nil];
    return order;
}

- (Model *)retainModel:(Model *)aModel withCount:(NSUInteger)aCount
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Model *model = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Model"
                    inManagedObjectContext:context];
    model.price = aModel.price;
    model.name = aModel.name;
    model.modelId = aModel.modelId;
    model.count = [NSNumber numberWithInt:aCount];
    aModel.count = [NSNumber numberWithInt:(aModel.count.integerValue - aCount)];
    [self updateSorce];
    return model;
}

- (void)removeOrder:(Order *)anOrder
{
    [self.managedObjectContext deleteObject:anOrder];
    [self updateSorce];
}

#pragma mark - Fetch Orders (Plan && Accounting)

- (NSArray *)ordersSortedWithKey:(NSString *)aKey ascending:(BOOL)anAscending
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Order" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = nil;
    if (aKey == kSortOrderKeyDate || aKey == kSortOrderKeyStatus)
    {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:aKey ascending:anAscending];        
    }
    else
    {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kSortOrderKeyDate ascending:anAscending];
    }
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError * error = nil;
    NSArray *recordsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (aKey == kSortOrderKeyReciever)
    {
        recordsArray = [recordsArray sortedArrayUsingComparator:^NSComparisonResult(Order * obj1, Order * obj2)
        {
            return anAscending ? [obj1.reciever.name compare:obj2.reciever.name] : [obj2.reciever.name compare:obj1.reciever.name];
        }];
    }
    if (aKey == kSortOrderKeyTotalPrice)
    {
        recordsArray = [recordsArray sortedArrayUsingComparator:^NSComparisonResult(Order * obj1, Order * obj2)
        {
            return anAscending ? obj1.totalPrice - obj2.totalPrice : obj2.totalPrice - obj1.totalPrice;
        }];
    }
    
    if (nil != error)
    {
        NSLog(@"Error while getting items from Persistance Storage");
        return nil;
    }
    return recordsArray;
}

- (NSArray *)ordersSortedWithKey:(NSString *)aKey
                       ascending:(BOOL)anAscending
             includeActiveOrders:(BOOL)anActiveFlag
           includeArchivedOrders:(BOOL)anArchivedFlag
                   withRecievers:(NSArray *)recieverIDs
                      withModels:(NSArray *)modelIDs
{
    NSArray *sortedArray = [self ordersSortedWithKey:aKey
                                           ascending:anAscending
                                 includeActiveOrders:anActiveFlag
                               includeArchivedOrders:anArchivedFlag];
    NSArray *filteredArray = [sortedArray filteredArrayUsingPredicate:
                              [NSPredicate predicateWithBlock:^BOOL(Order * evaluatedObject, NSDictionary *bindings)
    {
        BOOL found = NO;
        for (NSString *recieverID in recieverIDs)
        {
            if ([recieverID isEqualToString:evaluatedObject.reciever.companyID])
            {
                found = YES;
            }
        }
        if (!found)
        {
            return false;
        }
        
        found = NO;
        for (Model *model in evaluatedObject.model)
        {
            for (NSString * modelID in modelIDs)
            {
                if ([modelID isEqualToString:model.modelId])
                {
                    found = YES;
                }
            }
        }
        return found;
    }]];
    return filteredArray;
}


- (NSArray *)ordersSortedWithKey:(NSString *)aKey
                       ascending:(BOOL)anAscending
             includeActiveOrders:(BOOL)anActiveFlag
           includeArchivedOrders:(BOOL)anArchivedFlag
{
    NSArray *recordsArray = [self ordersSortedWithKey:aKey ascending:anAscending];

    if (anActiveFlag && anArchivedFlag)
    {
        return recordsArray;
    }
    if (anActiveFlag)
    {
        return [self activeOrdersFromOrders:recordsArray];
    }
    if (anArchivedFlag)
    {
        return [self archivedOrdersFromOrders:recordsArray];
    }
    return [NSArray array];
}

- (NSArray *)archivedOrdersFromOrders:(NSArray *)anOrders
{
    NSMutableArray *accounting = [NSMutableArray array];
    for (Order * order in anOrders)
    {
        if (order.status.integerValue == OrderInArchive)
        {
            [accounting addObject:order];
        }
    }
    return [accounting copy];
}

- (NSArray *)activeOrdersFromOrders:(NSArray *)anOrders
{
    NSMutableArray *planOrders = [NSMutableArray array];
    for (Order * order in anOrders)
    {
        if (order.status.integerValue == OrderActive)
        {
            [planOrders addObject:order];
        }
    }
    return [planOrders copy];
}

#pragma mark - Models

- (NSArray *)modelsOnWarhouse
{
    return [[self.warhouse.models allObjects] filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(Model * evaluatedObject, NSDictionary *bindings)
             {
                 return (NO == evaluatedObject.archived.boolValue);
             }]];
}
    
- (NSArray *)allModels
{
    return [self.warhouse.models allObjects];
}

- (Model *)addModelToWarhouseWithName:(NSString *)name andCost:(NSInteger)cost count:(NSUInteger)aCount
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Model *model = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Model"
                    inManagedObjectContext:context];
    model.price = [NSNumber numberWithInt:cost];
    model.name = name;
    model.modelId = [[NSUUID UUID] UUIDString];
    model.count = [NSNumber numberWithInt:aCount];
    model.archived = [NSNumber numberWithBool:NO];
    [[NSUserDefaults standardUserDefaults] addModelToDisplayList:model];
    [self.warhouse addModelsObject:model];
    [self updateSorce];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBUpdateModelsListNotification object:nil];
    return model;
}


- (void)removeModel:(Model *)aModel archivateModel:(BOOL)archivate
{
    if (archivate)
    {
        aModel.archived = [NSNumber numberWithBool:YES];
    }
    else
    {
        [self.warhouse removeModelsObject:aModel];
        NSArray *ordersToDelete = aModel.ordersWithModel;
        for (Order *order in ordersToDelete)
        {
            [self.managedObjectContext deleteObject:order];
        }
        [self.managedObjectContext deleteObject:aModel];
    }
    [self updateSorce];
}

#pragma mark - Recievers

- (NSArray *)recievers
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Reciever" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    
    NSError * error = nil;
    NSArray *recordsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [recordsArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Reciever * evaluatedObject, NSDictionary *bindings)
        {
            return !evaluatedObject.archived.integerValue;
        }]];
    
    if (nil != error)
    {
        NSLog(@"Error while getting items from Persistance Storage");
    }
    return [recordsArray copy];
}

- (Reciever *)addRecieverWithName:(NSString *)name adress:(NSString *)adress phone:(NSString *)phone account:(NSString *)account
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Reciever *reciever = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Reciever"
                    inManagedObjectContext:context];
    reciever.companyID = [[NSUUID UUID] UUIDString];
    reciever.name = name;
    reciever.adress = adress;
    reciever.phone = phone;
    reciever.account = account;
    reciever.archived = [NSNumber numberWithBool:NO];
    [[NSUserDefaults standardUserDefaults] addRecieverToDisplayList:reciever];
    [self updateSorce];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBUpdateRecieversListNotification object:nil];
    return reciever;
}

- (void)removeReciever:(Reciever *)aReciever archivateReciever:(BOOL)archivate
{
    if (archivate)
    {
        aReciever.archived = [NSNumber numberWithBool:YES];
    }
    else
    {
        NSArray *ordersToDelete = aReciever.ordersWithReciever;
    
        for (Order *order in ordersToDelete)
        {
            [self.managedObjectContext deleteObject:order];
        }
        [self.managedObjectContext deleteObject:aReciever];
    }
    [self updateSorce];
}


@end
