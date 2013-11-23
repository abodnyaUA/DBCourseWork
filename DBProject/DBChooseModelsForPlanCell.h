//
//  DBChooseModelsForPlanCell.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBChooseModelsForPlanCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel   *textLabelOutlet;
@property (strong, nonatomic) IBOutlet UILabel   *detailTextLabelOutlet;

- (NSUInteger)selectedCount;
- (IBAction)changeCount:(id)sender;
- (IBAction)didEditTextField:(id)sender;

@end
