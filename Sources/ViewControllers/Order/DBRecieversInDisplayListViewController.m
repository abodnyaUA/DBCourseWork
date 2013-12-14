//
//  DBRecieversInDisplayListViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 12/14/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBRecieversInDisplayListViewController.h"
#import "DBCoreDataManager.h"
#import "NSUserDefaults+OrderVC.h"

@interface DBRecieversInDisplayListViewController ()

@end

@implementation DBRecieversInDisplayListViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [DBCoreDataManager.sharedManager recievers].count;
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        Reciever * reciever = [[DBCoreDataManager.sharedManager recievers] objectAtIndex:indexPath.row];
        cell.textLabel.text = reciever.name;
        cell.accessoryType = [[NSUserDefaults standardUserDefaults] isRecieverInDisplayList:reciever] ?
        UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
        return cell;
    }
    
#pragma mark - Table view delegate
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        Reciever * reciever = [[DBCoreDataManager.sharedManager recievers] objectAtIndex:indexPath.row];
        if (cell.accessoryType == UITableViewCellAccessoryNone)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[NSUserDefaults standardUserDefaults] addRecieverToDisplayList:reciever];
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[NSUserDefaults standardUserDefaults] removeRecieverFromDisplayList:reciever];
        }
    }

@end
