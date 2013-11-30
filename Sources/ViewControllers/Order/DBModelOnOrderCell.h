//
//  DBModelOnOrderCell.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/30/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBModelOnOrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *modelName;
@property (strong, nonatomic) IBOutlet UILabel *modelCount;
@property (strong, nonatomic) IBOutlet UILabel *modelPrice;

@end
