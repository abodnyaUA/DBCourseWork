//
//  DBMakeOrderViewController.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBMakeOrderViewController.h"

#import "DBChooseModelsViewController.h"
#import "DBChooseRecieverViewController.h"
#import "DBCoreDataManager.h"
#import "DBModelBought.h"

@interface DBMakeOrderViewController ()

@property (strong, nonatomic) IBOutlet UIButton *chooseRecieverButton;
@property (strong, nonatomic) IBOutlet UIButton *chooseModelsButton;
@property (strong, nonatomic) IBOutlet UILabel *recieverLabel;
@property (strong, nonatomic) IBOutlet UITextView *modelsListTextView;
@property (strong, nonatomic) IBOutlet UILabel *orderPricelabel;

@property (strong, nonatomic) UIPopoverController *chooseRecieverPopover;
@property (strong, nonatomic) UIPopoverController *chooseModelsPopover;

@property (strong, nonatomic) DBChooseRecieverViewController *chooseRecieverVC;
@property (strong, nonatomic) DBChooseModelsViewController *chooseModelsVC;

@property (assign, nonatomic) NSUInteger totalPrice;

@end

@implementation DBMakeOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpPopovers];
    self.modelsListTextView.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
}

- (void)setUpPopovers
{
    self.chooseRecieverVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"ChooseRecieverViewController"];
    
    self.chooseRecieverPopover = [[UIPopoverController alloc] initWithContentViewController:self.chooseRecieverVC];
    self.chooseRecieverPopover.delegate = self;
    
    self.chooseModelsVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"ChooseModelsViewController"];
    
    self.chooseModelsPopover = [[UIPopoverController alloc] initWithContentViewController:self.chooseModelsVC];
    self.chooseModelsPopover.delegate = self;
}

- (IBAction)chooseRecieverButtonHandler:(id)sender
{
    [self.chooseRecieverPopover presentPopoverFromRect:self.chooseRecieverButton.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
}

- (IBAction)chooseModelsButtonHandler:(id)sender
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
        self.orderPricelabel.text = [NSString stringWithFormat:@"%d $",self.totalPrice];
        return;
    }
    if (popoverController == self.chooseRecieverPopover)
    {
        NSUInteger recieverNumber = self.chooseRecieverVC.selectedRecieverNumber;
        if (NSNotFound != recieverNumber)
        {
            Reciever *reciever = [[DBCoreDataManager.sharedManager recievers] objectAtIndex:self.chooseRecieverVC.selectedRecieverNumber];
            self.recieverLabel.text = reciever.name;
        }
    }
}

@end
