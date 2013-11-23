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
    cell.detailTextLabelOutlet.text = [NSString stringWithFormat:@"%@ $ (Count: %d)",model.price.description,model.count.integerValue];
    [cell setMaxCount:model.count.integerValue];
    
    return cell;
}

- (NSDictionary *)selectedModels
{
    NSMutableDictionary *models = [NSMutableDictionary dictionary];
    NSUInteger cellsNumber = [DBCoreDataManager.sharedManager modelsOnWarhouse].count;
    for (int i=0; i < cellsNumber; i++)
    {
        DBChooseModelsCell *cell = (DBChooseModelsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        Model * model = [[DBCoreDataManager.sharedManager modelsOnWarhouse] objectAtIndex:i];
        [models setValue:[NSNumber numberWithInt:cell.selectedCount] forKey:model.modelId];
    }
    return models;
}

@end
