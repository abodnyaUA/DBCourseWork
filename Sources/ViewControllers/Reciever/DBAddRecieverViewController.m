//
//  DBAddRecieverViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBAddRecieverViewController.h"

#import "DBCoreDataManager.h"
#import "DBConstants.h"


@interface DBAddRecieverViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelBank;
@property (strong, nonatomic) IBOutlet UILabel *labelPhone;
@property (strong, nonatomic) IBOutlet UILabel *labelAdress;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *adressTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *bankAccountTextField;

@end

@implementation DBAddRecieverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = kStoryboardNewReciever;
    self.labelBank.text = kStoryboardAddRecieverBank;
    self.labelPhone.text = kStoryboardAddRecieverPhone;
    self.labelAdress.text = kStoryboardAddRecieverAdress;
    
    self.nameTextField.placeholder = kStoryboardAddRecieverNamePlaceholder;
    self.adressTextField.placeholder = kStoryboardAddRecieverAdressPlaceholder;
    self.phoneTextField.placeholder = kStoryboardAddRecieverPhonePlaceholder;
    self.bankAccountTextField.placeholder = kStoryboardAddRecieverBankPlaceholder;
}

- (IBAction)doneClicked:(id)sender
{
    [DBCoreDataManager.sharedManager addRecieverWithName:self.nameTextField.text
                                                  adress:self.adressTextField.text
                                                   phone:self.phoneTextField.text
                                                 account:self.bankAccountTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
