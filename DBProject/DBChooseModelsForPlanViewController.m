//
//  DBChooseModelsViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBChooseModelsForPlanViewController.h"

#import "DBCoreDataManager.h"
#import "DBChooseModelsForPlanCell.h"
#import "DBModelBought.h"


@interface DBChooseModelsForPlanViewController ()

@end

@implementation DBChooseModelsForPlanViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DBCoreDataManager.sharedManager modelsOnWarhouse].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"chooseModelCell";
    DBChooseModelsForPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:indexPath.row];
    cell.textLabelOutlet.text = model.name;
    cell.detailTextLabelOutlet.text = [NSString stringWithFormat:@"%@ $ (Enable %d)",model.price.description,model.count.integerValue];
    
    return cell;
}

- (NSArray *)selectedModels
{
    NSMutableArray *models = [NSMutableArray array];
    NSUInteger cellsNumber = [DBCoreDataManager.sharedManager modelsOnWarhouse].count;
    for (int i=0; i < cellsNumber; i++)
    {
        DBChooseModelsForPlanCell *cell = (DBChooseModelsForPlanCell *)[self.tableView
                                                                        cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.selectedCount > 0)
        {
            Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:i];
            [models addObject:[DBModelBought boughtWithModel:model andCount:cell.selectedCount]];
        }
    }
    return [models copy];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
