//
//  DBChooseRecieverViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBChooseRecieverViewController.h"

#import "DBCoreDataManager.h"


@interface DBChooseRecieverViewController ()

@end

@implementation DBChooseRecieverViewController

- (void)viewDidLoad
{
    self.selectedRecieverNumber = NSNotFound;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DBCoreDataManager.sharedManager recievers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"chooseRecieverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Reciever *obj = [[DBCoreDataManager.sharedManager recievers] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = obj.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (phone: %@)",obj.adress,obj.phone];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (NSNotFound != self.selectedRecieverNumber && self.selectedRecieverNumber != indexPath.row)
    {
        [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRecieverNumber inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    self.selectedRecieverNumber = indexPath.row;
}

@end
