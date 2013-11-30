//
//  DBRecieverListViewController.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBRecieverListViewController.h"

#import "DBRecieverDetailViewController.h"
#import "DBCoreDataManager.h"
#import "DBConstants.h"


@interface DBRecieverListViewController ()

@end

@implementation DBRecieverListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = kStoryboardRecieversListTitle;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSource)
                                                 name:DBUpdateRecieversListNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DBUpdateRecieversListNotification object:nil];
}

- (void)updateViewWithSource
{
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DBCoreDataManager.sharedManager recievers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"recieverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Reciever *obj = [[DBCoreDataManager.sharedManager recievers] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = obj.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (phone: %@)",obj.adress,obj.phone];
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView  editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray * data = [[DBCoreDataManager.sharedManager recievers] copy];
        Model * model = [data objectAtIndex:indexPath.row];
        [DBCoreDataManager.sharedManager removeObject:model];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBRecieverDetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"RecieverDetailViewController"];
    detailViewController.reciever = [[DBCoreDataManager.sharedManager recievers] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
