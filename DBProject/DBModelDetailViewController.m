//
//  DBModelDetailViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBModelDetailViewController.h"

#import "DBConstants.h"

@interface DBModelDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelModelID;
@property (strong, nonatomic) IBOutlet UILabel *labelCount;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;

@property (strong, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *countTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelIDTextLabel;

@end

@implementation DBModelDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.nameTextLabel.text = self.model.name;
	self.countTextLabel.text = self.model.count.description;
	self.priceTextLabel.text = self.model.price.description;
    self.modelIDTextLabel.text = self.model.modelId;
    
    self.labelModelID.text = kStoryboardModelDetailID;
    self.labelCount.text = kStoryboardModelDetailCount;
    self.labelPrice.text = kStoryboardModelDetailPrice;
    
    self.navigationItem.title = self.model.name;
}

@end
