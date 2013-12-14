//
//  DBSortDisplayListViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 12/14/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBSortDisplayListViewController.h"
#import "NSUserDefaults+OrderVC.h"
#import "DBConstants.h"


const NSUInteger kSortTableViewSectionCategory = 0;
const NSUInteger kSortTableViewSectionAscDesc = 1;

@interface DBSortDisplayListViewController ()

@property (strong, nonatomic) NSDictionary *sortList;
@property (assign, nonatomic) NSUInteger sortRow;
    
@end

@implementation DBSortDisplayListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sortList = @{@"Reciever" : kSortOrderKeyReciever,
                      @"Date"     : kSortOrderKeyDate,
                      @"Price"    : kSortOrderKeyTotalPrice,
                      @"Status"   : kSortOrderKeyStatus};
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == kSortTableViewSectionCategory ? self.sortList.count : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == kSortTableViewSectionCategory)
    {
        cell.textLabel.text = [[self.sortList allKeys] objectAtIndex:indexPath.row];
        if ([[[NSUserDefaults standardUserDefaults] orderFetchSortKey] isEqualToString:[[self.sortList allValues] objectAtIndex:indexPath.row]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.sortRow = indexPath.row;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else
    {
        cell.textLabel.text = indexPath.row == 0 ? @"Ascending" : @"Descending";
        if ([[NSUserDefaults standardUserDefaults] orderFetchAscendingFlag] && indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        return;
    }
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if (indexPath.section == kSortTableViewSectionCategory)
    {
        UITableViewCell *currentKeyCell = [tableView cellForRowAtIndexPath:
                                           [NSIndexPath indexPathForItem:self.sortRow inSection:kSortTableViewSectionCategory]];
        currentKeyCell.accessoryType = UITableViewCellAccessoryNone;
        self.sortRow = indexPath.row;
        [[NSUserDefaults standardUserDefaults] setOrderFetchSortKey:[self.sortList valueForKey:[self.sortList.allKeys objectAtIndex:indexPath.row]]];
    }
    else
    {
        UITableViewCell *currentKeyCell = [tableView cellForRowAtIndexPath:
                                           [NSIndexPath indexPathForRow:1 - indexPath.row inSection:kSortTableViewSectionAscDesc]];
        currentKeyCell.accessoryType = UITableViewCellAccessoryNone;
        [[NSUserDefaults standardUserDefaults] setOrderFetchAscendingFlag:(indexPath.row == 0)];
    }
}

@end
