//
//  DBChoosModelsCell.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBChooseModelsCell.h"


@interface DBChooseModelsCell ()

@property (strong, nonatomic) UILabel   *countLabel;
@property (strong, nonatomic) UIStepper *countStepper;

@end

@implementation DBChooseModelsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.countStepper = [[UIStepper alloc] initWithFrame:CGRectMake(self.frame.origin.x-115,
                                                                        (self.frame.size.height-27)/2.0,
                                                                        98,
                                                                        27)];
        [self.countStepper addTarget:self action:@selector(stepperPressed:) forControlEvents:UIControlEventValueChanged];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x-120-40,
                                                                    (self.frame.size.height-27)/2.0,
                                                                    40,
                                                                    27)];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)stepperPressed:(UIStepper *)aSteper
{
    [self.countLabel setText:[NSString stringWithFormat:@"%d", (NSUInteger)aSteper.value]];
}

- (NSUInteger)selectedCount
{
    return self.countStepper.value;
}

- (void)setMaxCount:(NSUInteger)aMaxValue
{
    self.countStepper.maximumValue = aMaxValue;
}

@end
