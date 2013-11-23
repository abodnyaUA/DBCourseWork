//
//  DBAddYearPlanViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBAddYearPlanViewController.h"

#import "DBChooseModelsForPlanViewController.h"
#import "DBModelBought.h"


@interface DBAddYearPlanViewController ()

@property (strong, nonatomic) UIPopoverController *chooseModelsPopover;
@property (strong, nonatomic) DBChooseModelsForPlanViewController *chooseModelsVC;
@property (strong, nonatomic) IBOutlet UIButton *chooseModelsButton;
@property (strong, nonatomic) IBOutlet UITextView *modelsListTextView;

@property (strong, nonatomic) IBOutlet UITextField *yearTextField;
@property (strong, nonatomic) IBOutlet UITextField *authorTextField;
@property (strong, nonatomic) IBOutlet UILabel *yearsPlanPrice;

@property (assign, nonatomic) NSUInteger totalPrice;

@end

@implementation DBAddYearPlanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPopovers];
    self.modelsListTextView.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
}

- (void)setUpPopovers
{
    self.chooseModelsVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"ChooseModelsForPlanViewController"];
    
    self.chooseModelsPopover = [[UIPopoverController alloc] initWithContentViewController:self.chooseModelsVC];
    self.chooseModelsPopover.delegate = self;
}

- (IBAction)chooseModels:(id)sender
{
    [self.chooseModelsPopover presentPopoverFromRect:self.chooseModelsButton.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == self.chooseModelsPopover)
    {
        self.modelsListTextView.text = @"";
        NSString *modelsList = @"";
        NSArray *models = [self.chooseModelsVC selectedModels];
        self.totalPrice = 0;
        for (DBModelBought * modelBought in models)
        {
            Model * model = modelBought.model;
            NSUInteger price = modelBought.count*model.price.integerValue;
            self.totalPrice += price;
            modelsList = [modelsList stringByAppendingFormat:@"%@ - %d (%d $)\n",
                          model.name,modelBought.count,price];
        }
        self.modelsListTextView.text = modelsList;
        self.yearsPlanPrice.text = [NSString stringWithFormat:@"%d $",self.totalPrice];
        return;
    }
}

- (IBAction)doneCreatingPlan:(id)sender
{
    if (self.yearTextField.text.integerValue < 1980 || self.yearTextField.text.integerValue > 2080)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Wrong year", nil)
                                                        message:NSLocalizedString(@"Year must be between 1980 and 2080",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Continue Fill",nil)
                                              otherButtonTitles:NSLocalizedString(@"Cancel Edit",nil), nil];
        [alert show];
        return;
    }
    
    if (self.authorTextField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missed author", nil)
                                                        message:NSLocalizedString(@"Year must set who is the plan's author",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Continue Fill",nil)
                                              otherButtonTitles:NSLocalizedString(@"Cancel Edit",nil), nil];
        [alert show];
        return;
    }

    
    NSMutableArray *planModels = [NSMutableArray array];
    NSArray *modelsBought = [self.chooseModelsVC selectedModels];
    
    if (modelsBought.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missed Models", nil)
                                                        message:NSLocalizedString(@"You haven't select any model",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Continue Fill",nil)
                                              otherButtonTitles:NSLocalizedString(@"Cancel Edit",nil), nil];
        [alert show];
        return;
    }
    
    for (DBModelBought * modelBought in modelsBought)
    {
        Model *planModel = [DBCoreDataManager.sharedManager copyModel:modelBought.model withNewCount:modelBought.count];
        [planModels addObject:planModel];
    }
    
    [DBCoreDataManager.sharedManager addPlanForYear:self.yearTextField.text.integerValue
                                         withModels:planModels
                                         withAuthor:self.authorTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
