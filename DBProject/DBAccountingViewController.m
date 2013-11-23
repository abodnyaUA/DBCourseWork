//
//  DBAccountingViewController.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBAccountingViewController.h"

#import "DBCoreDataManager.h"
#import "DBOrderDetailViewController.h"
#import "DBAppDelegate.h"

@interface DBAccountingViewController ()

@end

@implementation DBAccountingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSource)
                                                 name:DBOrderWasAddedNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DBOrderWasAddedNotification object:nil];
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
    return [DBCoreDataManager.sharedManager accounting].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"orderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Order * obj = [[DBCoreDataManager.sharedManager accounting] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"[%@] %@",[DBAppDelegate.sharedInstance.formatter stringFromDate:obj.orderDate],((Reciever *)obj.reciever).name];
    NSString *detailText = @"";
    for (Model *model in obj.model)
    {
        detailText = [detailText stringByAppendingString:model.name];
        detailText = [detailText stringByAppendingString:@", "];
    }
    cell.detailTextLabel.text = [detailText substringToIndex:detailText.length-2];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBOrderDetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
    detailViewController.order = [[DBCoreDataManager.sharedManager accounting] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
