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

@interface DBOrderDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverAccountLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverPhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *recieverAdressLabel;
@property (strong, nonatomic) IBOutlet UITextView *modelsTextView;

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
    NSString *modelsList = @"";
    for (Model *model in self.order.model)
    {
        NSUInteger price = model.count.integerValue * model.price.integerValue;
        modelsList = [modelsList stringByAppendingFormat:@"%@ - %d (%d $)\n",
                      model.name,model.count.integerValue,price];
    }
    self.modelsTextView.text = modelsList;
    self.modelsTextView.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
    self.orderDateLabel.text = [DBAppDelegate.sharedInstance.formatter stringFromDate:self.order.orderDate];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Order to %@",self.order.reciever.name];
}

- (IBAction)share:(id)sender
{
    NSString *fileName = [NSString stringWithFormat:@"Order_%@",self.order.orderId];
    NSURL * url = [NSURL fileURLWithPath:[DBAppDelegate createPDFfromUIView:self.view saveToDocumentsWithFileName:fileName]];
    
    UIActivityViewController *activityPublisher =
    [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    
    [self presentViewController:activityPublisher animated:YES completion:nil];
}

@end
