//
//  DBModelsListViewController.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBModelsListViewController.h"

#import "DBModelDetailViewController.h"
#import "DBCoreDataManager.h"
#import "DBConstants.h"


@interface DBModelsListViewController ()

@end

@implementation DBModelsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = kStoryboardModelsListTitle;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSource)
                                                 name:DBUpdateModelsListNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DBUpdateModelsListNotification object:nil];
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
    return [DBCoreDataManager.sharedManager modelsOnWarhouse].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"modelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ $ (Count: %d)",model.price.description,model.count.integerValue];
    
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
        NSArray * data = [[DBCoreDataManager.sharedManager models] copy];
        Model * model = [data objectAtIndex:indexPath.row];
        [DBCoreDataManager.sharedManager removeObject:model];
        [self.tableView reloadData];
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBModelDetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"ModelDetailViewController"];
    detailViewController.model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
