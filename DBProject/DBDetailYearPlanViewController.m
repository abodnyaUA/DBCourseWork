//
//  DBDetailYearPlanViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBDetailYearPlanViewController.h"

#import "Model.h"
#import "DBAppDelegate.h"

@interface DBDetailYearPlanViewController ()

@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearsPlanPrice;
@property (strong, nonatomic) IBOutlet UITextView *modelsListTextView;
@property (strong, nonatomic) IBOutlet UILabel *creationDateLabel;

@end

@implementation DBDetailYearPlanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.yearLabel.text = [NSString stringWithFormat:@"%d",self.plan.year.integerValue];
    self.authorLabel.text = self.plan.author;
    self.yearsPlanPrice.text = [NSString stringWithFormat:@"%d $",self.plan.totalPrice];
    NSString *modelsList = @"";
    for (Model *model in self.plan.models)
    {
        NSUInteger price = model.count.integerValue * model.price.integerValue;
        modelsList = [modelsList stringByAppendingFormat:@"%@ - %d (%d $)\n",
                      model.name,model.count.integerValue,price];
    }
    self.modelsListTextView.text = modelsList;
    self.modelsListTextView.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
    self.creationDateLabel.text = [DBAppDelegate.sharedInstance.formatter stringFromDate:self.plan.creationDate];
}

@end
