//
//  DBRecieverDetailViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBRecieverDetailViewController.h"

#import "DBConstants.h"


@interface DBRecieverDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelCompany;
@property (strong, nonatomic) IBOutlet UILabel *labelBank;
@property (strong, nonatomic) IBOutlet UILabel *labelPhone;
@property (strong, nonatomic) IBOutlet UILabel *labelAdress;

@property (strong, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *adressTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *bankAccountTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverIDTextLabel;

@end

@implementation DBRecieverDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.nameTextLabel.text = self.reciever.name;
	self.adressTextLabel.text = self.reciever.adress;
	self.phoneTextLabel.text = self.reciever.phone;
	self.bankAccountTextLabel.text = self.reciever.account;
	self.recieverIDTextLabel.text = self.reciever.companyID;
    
    self.labelCompany.text = kStoryboardRecieverDetailID;
    self.labelBank.text = kStoryboardRecieverDetailBank;
    self.labelPhone.text = kStoryboardRecieverDetailPhone;
    self.labelAdress.text = kStoryboardRecieverDetailAdress;
    
    self.navigationItem.title = self.reciever.name;
}

@end
