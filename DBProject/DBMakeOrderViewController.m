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

@interface DBMakeOrderViewController ()

@property (strong, nonatomic) IBOutlet UIButton *chooseRecieverButton;
@property (strong, nonatomic) IBOutlet UIButton *chooseModelsButton;
@property (strong, nonatomic) IBOutlet UILabel *recieverLabel;
@property (strong, nonatomic) IBOutlet UITextView *modelsListtextView;

@property (strong, nonatomic) UIPopoverController *chooseRecieverPopover;
@property (strong, nonatomic) UIPopoverController *chooseModelsPopover;

@end

@implementation DBMakeOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)chooseRecieverButtonHandler:(id)sender
{
    DBChooseRecieverViewController *chooseRecieverVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"ChooseRecieverViewController"];
    
    self.chooseRecieverPopover = [[UIPopoverController alloc] initWithContentViewController:chooseRecieverVC];
    [self.chooseRecieverPopover presentPopoverFromRect:self.chooseRecieverButton.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
}

- (IBAction)chooseModelsButtonHandler:(id)sender
{
    DBChooseModelsViewController *chooseModelsVC = [[DBChooseModelsViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.chooseModelsPopover = [[UIPopoverController alloc] initWithContentViewController:chooseModelsVC];
    [self.chooseModelsPopover presentPopoverFromRect:self.chooseModelsButton.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
}


@end
