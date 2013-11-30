//
//  DBAddModelViewController.m
//  DBProject
//
//  Created by abodnya on 10/29/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBAddModelViewController.h"

#import "DBCoreDataManager.h"
#import "DBConstants.h"

@interface DBAddModelViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelCount;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UITextField *countTextField;

@end

@implementation DBAddModelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelCount.text = kStoryboardAddModelCount;
    self.labelPrice.text = kStoryboardAddModelPrice;
}

- (IBAction)doneClicked:(id)sender
{
    [DBCoreDataManager.sharedManager addModelToWarhouseWithName:self.nameTextField.text andCost:[self.priceTextField.text integerValue] count:[self.countTextField.text integerValue]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
