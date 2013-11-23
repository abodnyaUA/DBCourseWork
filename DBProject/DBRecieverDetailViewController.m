//
//  DBRecieverDetailViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBRecieverDetailViewController.h"

@interface DBRecieverDetailViewController ()

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
    
    self.navigationItem.title = self.reciever.name;
}

@end
