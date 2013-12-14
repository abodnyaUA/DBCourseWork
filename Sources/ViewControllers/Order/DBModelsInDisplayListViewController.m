//
//  DBModelsInDisplayListViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 12/14/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBModelsInDisplayListViewController.h"
#import "DBCoreDataManager.h"
#import "NSUserDefaults+OrderVC.h"

@interface DBModelsInDisplayListViewController ()

@end

@implementation DBModelsInDisplayListViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DBCoreDataManager.sharedManager allModels].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.accessoryType = [[NSUserDefaults standardUserDefaults] isModelInDisplayList:model] ?
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:indexPath.row];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[NSUserDefaults standardUserDefaults] addModelToDisplayList:model];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[NSUserDefaults standardUserDefaults] removeModelFromDisplayList:model];
    }
}

@end
