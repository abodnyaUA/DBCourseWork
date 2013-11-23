//
//  DBCoreDataManager.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBCoreDataManager.h"

#import "DBAppDelegate.h"


NSString * const DBModelWasAddedNotification = @"DBModelWasAddedNotification";
NSString * const DBRecieverWasAddedNotification = @"DBRecieverWasAddedNotification";

@interface DBCoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

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

#pragma mark - Accounting

- (NSArray *)accounting
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Accounting" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError * error = nil;
    NSArray *recordsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (nil != error)
    {
        NSLog(@"Error while getting items from Persistance Storage");
    }
    return [recordsArray copy];
}

#pragma mark - Models

- (NSArray *)models
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Model" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError * error = nil;
    NSArray *recordsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (nil != error)
    {
        NSLog(@"Error while getting items from Persistance Storage");
    }
    return [recordsArray copy];
}

- (Model *)addModelWithName:(NSString *)name andCost:(NSInteger)cost count:(NSUInteger)aCount
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Model *model = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Model"
                                inManagedObjectContext:context];
    model.price = [NSNumber numberWithInt:cost];
    model.name = name;
    model.modelId = [[NSUUID UUID] UUIDString];
    model.count = [NSNumber numberWithInt:aCount];
    [self updateSorce];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBModelWasAddedNotification object:nil];
    return model;
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
    [self updateSorce];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBRecieverWasAddedNotification object:nil];
    return reciever;
}

@end
