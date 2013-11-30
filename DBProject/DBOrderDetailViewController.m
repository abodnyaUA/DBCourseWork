//
//  DBOrderDetailViewController.m
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBOrderDetailViewController.h"
#import "Model.h"
#import "Reciever.h"
#import "DBAppDelegate.h"
#import "DBConstants.h"
#import "DBModelOnOrderCell.h"
#import <QuartzCore/QuartzCore.h>


@interface DBOrderDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelCompany__;
@property (strong, nonatomic) IBOutlet UILabel *labelReciever__;
@property (strong, nonatomic) IBOutlet UILabel *labelTotal;
@property (strong, nonatomic) IBOutlet UILabel *labelModels;
@property (strong, nonatomic) IBOutlet UILabel *labelBank;
@property (strong, nonatomic) IBOutlet UILabel *labelPhone;
@property (strong, nonatomic) IBOutlet UILabel *labelAdress;
@property (strong, nonatomic) IBOutlet UILabel *labelReciever;
@property (strong, nonatomic) IBOutlet UILabel *labelOrderNumber;

@property (strong, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverAccountLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverPhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverAdressLabel;
@property (strong, nonatomic) IBOutlet UITextView *modelsTextView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonChangeStatus;
@property (strong, nonatomic) IBOutlet UITableView *modelsListTableView;

@end

@implementation DBOrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.orderIDLabel.text = self.order.orderId;
	self.totalPriceLabel.text = [NSString stringWithFormat:@"%d $", self.order.totalPrice];
    self.recieverNameLabel.text = self.order.reciever.name;
    self.recieverPhoneLabel.text = self.order.reciever.phone;
    self.recieverAdressLabel.text = self.order.reciever.adress;
    self.recieverAccountLabel.text = self.order.reciever.account;
    self.orderDateLabel.text = [DBAppDelegate.sharedInstance.formatter stringFromDate:self.order.orderDate];
    
    self.navigationItem.title = [NSString stringWithFormat:kNavigationBarTitleOrder,self.order.reciever.name];
    
    self.buttonChangeStatus.title = self.order.status.integerValue == OrderActive ? kMoveInArchiveOrderString : kMakeActiveOrderString;
    
    self.modelsListTableView.delegate = self;
    self.modelsListTableView.dataSource = self;
    
    self.labelCompany__.text = kStoryboardOrderDetailCompany__;
    self.labelReciever__.text = kStoryboardOrderDetailReciever__;
    self.labelTotal.text = kStoryboardOrderDetailTotal;
    self.labelModels.text = kStoryboardOrderDetailModels;
    self.labelBank.text = kStoryboardOrderDetailBank;
    self.labelPhone.text = kStoryboardOrderDetailPhone;
    self.labelAdress.text = kStoryboardOrderDetailAdress;
    self.labelReciever.text = kStoryboardOrderDetailReciever;
    self.labelOrderNumber.text = kStoryboardOrderDetailOrderNumber;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)share:(id)sender
{
    NSString *fileName = [NSString stringWithFormat:@"Order_%@",self.order.orderId];
    NSURL * url = [NSURL fileURLWithPath:[DBAppDelegate createPDFfromUIView:self.view saveToDocumentsWithFileName:fileName]];
    
    UIActivityViewController *activityPublisher =
    [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    
    [self presentViewController:activityPublisher animated:YES completion:nil];
}

- (IBAction)deleteOrder:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertDeleteOrderTitle
                                                    message:kAlertDeleteOrderText
                                                   delegate:self
                                          cancelButtonTitle:kAlertButtonDelete
                                          otherButtonTitles:kAlertButtonCancel, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [DBCoreDataManager.sharedManager removeObject:self.order];
        [[NSNotificationCenter defaultCenter] postNotificationName:DBUpdateOrdersListNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)changeOrderStatus:(id)sender
{
    NSUInteger newStatus = self.order.status.integerValue == OrderActive ? OrderInArchive : OrderActive;
    self.order.status = [NSNumber numberWithInt:newStatus];
    self.buttonChangeStatus.title = newStatus == OrderActive ? kMoveInArchiveOrderString : kMakeActiveOrderString;
    [[NSNotificationCenter defaultCenter] postNotificationName:DBUpdateOrdersListNotification object:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.order.model.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"modelCell";
    DBModelOnOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0;
    
    if (indexPath.row == 0)
    {
        cell.modelName.text = kOrderModelNameTableColomn;
        cell.modelCount.text = kOrderModelCountTableColomn;
        cell.modelPrice.text = kOrderModelPriceTableColomn;
        cell.modelName.font = [UIFont boldSystemFontOfSize:17.0];
        cell.modelCount.font = [UIFont boldSystemFontOfSize:17.0];
        cell.modelPrice.font = [UIFont boldSystemFontOfSize:17.0];
    }
    else
    {
        Model *model = [self.order.model.allObjects objectAtIndex:indexPath.row-1];
        cell.modelName.text = model.name;
        cell.modelPrice.text = [NSString stringWithFormat:@"%d $",model.price.integerValue];
        cell.modelCount.text = [NSString stringWithFormat:@"%d",model.count.integerValue];
    }
    return cell;
}



@end
