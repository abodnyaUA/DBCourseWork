//
//  DBChoosModelsCell.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBChooseModelsCell.h"


@interface DBChooseModelsCell ()

@property (strong, nonatomic) IBOutlet UILabel   *countLabel;
@property (strong, nonatomic) IBOutlet UIStepper *countStepper;

@end

@implementation DBChooseModelsCell

- (IBAction)changeCount:(id)sender
{
    [self.countLabel setText:[NSString stringWithFormat:@"%d of %d",
                              (NSUInteger)self.countStepper.value,
                              (NSUInteger)self.countStepper.maximumValue]];
}

- (NSUInteger)selectedCount
{
    return self.countStepper.value;
}

- (void)setMaxCount:(NSUInteger)aMaxValue
{
    self.countStepper.maximumValue = aMaxValue;
    self.countLabel.text = [NSString stringWithFormat:@"%d of %d",(NSUInteger)self.countStepper.value,aMaxValue];
}

@end
