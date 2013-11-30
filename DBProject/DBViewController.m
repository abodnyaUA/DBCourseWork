//
//  DBViewController.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBViewController.h"

#import "DBConstants.h"

@interface DBViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelOrderList;
@property (strong, nonatomic) IBOutlet UILabel *labelNewOrder;
@property (strong, nonatomic) IBOutlet UILabel *labelRecievers;
@property (strong, nonatomic) IBOutlet UILabel *labelModelsOnWarehouse;

@end

@implementation DBViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = YES;
    self.labelOrderList.text = kStoryboardMainOrderList;
    self.labelNewOrder.text = kStoryboardMainRecieverList;
    self.labelRecievers.text = kStoryboardMainModelList;
    self.labelModelsOnWarehouse.text = kStoryboardMainNewOrder;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
