//
//  DBChooseModelsViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBChooseModelsViewController.h"

#import "DBCoreDataManager.h"
#import "DBChooseModelsCell.h"
#import "DBModelBought.h"


@interface DBChooseModelsViewController ()

@end

@implementation DBChooseModelsViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DBCoreDataManager.sharedManager modelsOnWarhouse].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"chooseModelCell";
    DBChooseModelsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:indexPath.row];
    cell.textLabelOutlet.text = model.name;
    cell.detailTextLabelOutlet.text = [NSString stringWithFormat:@"%@ $",model.price.description];
    [cell setMaxCount:model.count.integerValue];
    
    return cell;
}

- (NSArray *)selectedModels
{
    NSMutableArray *models = [NSMutableArray array];
    NSUInteger cellsNumber = [DBCoreDataManager.sharedManager modelsOnWarhouse].count;
    for (int i=0; i < cellsNumber; i++)
    {
        DBChooseModelsCell *cell = (DBChooseModelsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.selectedCount > 0)
        {
            Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:i];
            [models addObject:[DBModelBought boughtWithModel:model andCount:cell.selectedCount]];
        }
    }
    return [models copy];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
