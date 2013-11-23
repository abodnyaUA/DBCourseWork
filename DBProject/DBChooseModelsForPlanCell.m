//
//  DBChooseModelsForPlanCell.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBChooseModelsForPlanCell.h"

@interface DBChooseModelsForPlanCell ()

@property (strong, nonatomic) IBOutlet UITextField *countTextField;
@property (strong, nonatomic) IBOutlet UIStepper *countStepper;

@end

@implementation DBChooseModelsForPlanCell

- (IBAction)changeCount:(id)sender
{
    [self.countTextField setText:[NSString stringWithFormat:@"%d",
                              (NSUInteger)self.countStepper.value]];
}

- (IBAction)didEditTextField:(id)sender
{
    self.countStepper.value = self.countTextField.text.doubleValue;
}

- (NSUInteger)selectedCount
{
    return self.countStepper.value;
}

@end
