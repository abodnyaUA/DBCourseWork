//
//  DBChoosModelsCell.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBChooseModelsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel   *textLabelOutlet;
@property (strong, nonatomic) IBOutlet UILabel   *detailTextLabelOutlet;

- (NSUInteger)selectedCount;
- (void)setMaxCount:(NSUInteger)aMaxValue;
- (IBAction)changeCount:(id)sender;

@end
