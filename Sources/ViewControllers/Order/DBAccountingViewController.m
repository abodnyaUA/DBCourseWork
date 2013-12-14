//
//  DBAccountingViewController.m
//  DBProject
//
//  Created by abodnya on 10/28/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBAccountingViewController.h"

#import "DBCoreDataManager.h"
#import "DBOrderDetailViewController.h"
#import "DBAppDelegate.h"
#import "NSUserDefaults+OrderVC.h"
#import "DBConstants.h"
#import "DBOrderCell.h"

#import "DBRecieversInDisplayListViewController.h"
#import "DBModelsInDisplayListViewController.h"
#import "DBSortDisplayListViewController.h"

@interface DBAccountingViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *labelSortWith;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *labelStatus;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonSort;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonReciever;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonModels;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonShowActive;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonShowArchived;

    
@property (strong, nonatomic) UIPopoverController *chooseRecieversPopover;
@property (strong, nonatomic) UIPopoverController *chooseModelsPopover;
@property (strong, nonatomic) UIPopoverController *changeSortKeyPopover;

@property (strong, nonatomic) DBRecieversInDisplayListViewController *chooseRecieversVC;
@property (strong, nonatomic) DBModelsInDisplayListViewController *chooseModelsVC;
@property (strong, nonatomic) DBSortDisplayListViewController *changeSortKeyVC;
    
@end

@implementation DBAccountingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSource)
                                                 name:DBUpdateOrdersListNotification
                                               object:nil];
    
    self.navigationController.toolbarHidden = NO;
    self.navigationItem.title = kStoryboardOrderListTitle;
    BOOL showActiveFlag = NSUserDefaults.standardUserDefaults.showActiveOrders;
    self.buttonShowActive.tintColor = showActiveFlag     ? [UIColor blackColor] : [UIColor grayColor];
    BOOL showArchivedFlag = NSUserDefaults.standardUserDefaults.showArchivedOrders;
    self.buttonShowArchived.tintColor = showArchivedFlag ? [UIColor blackColor] : [UIColor grayColor];
    
    self.labelSortWith.title = kStoryboardOrderListLabelSort;
    self.labelStatus.title = kStoryboardOrderListLabelShow;
    
//    self.buttonSortStatus.title = kStoryboardOrderListSortStatus;
//    self.buttonSortDate.title = kStoryboardOrderListSortDate;
//    self.buttonSortPrice.title = kStoryboardOrderListSortPrice;
//    self.buttonSortReciever.title = kStoryboardOrderListSortReciever;
    
    self.buttonShowActive.title = kStoryboardOrderListShowActive;
    self.buttonShowArchived.title = kStoryboardOrderListShowArchived;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DBUpdateOrdersListNotification object:nil];
}

- (void)updateViewWithSource
{
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (NSArray *)dataSource
{
    return [DBCoreDataManager.sharedManager ordersSortedWithKey:NSUserDefaults.standardUserDefaults.orderFetchSortKey
                                                      ascending:NSUserDefaults.standardUserDefaults.orderFetchAscendingFlag
                                            includeActiveOrders:NSUserDefaults.standardUserDefaults.showActiveOrders
                                          includeArchivedOrders:NSUserDefaults.standardUserDefaults.showArchivedOrders];
}

#pragma mark -
    
- (void)setUpPopovers
{
    //
    self.chooseRecieversVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"RecieversInDisplayListViewController"];
    
    self.chooseRecieversPopover = [[UIPopoverController alloc] initWithContentViewController:self.chooseRecieversVC];
    self.chooseRecieversPopover.delegate = self;
    
    //
    self.chooseModelsVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"ModelsInDisplayListViewController"];
    
    self.chooseModelsPopover = [[UIPopoverController alloc] initWithContentViewController:self.chooseModelsVC];
    self.chooseModelsPopover.delegate = self;
    
    //
    self.changeSortKeyVC = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"SortDisplayListViewController"];
    
    self.changeSortKeyPopover = [[UIPopoverController alloc] initWithContentViewController:self.changeSortKeyVC];
    self.changeSortKeyPopover.delegate = self;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self.tableView reloadData];
//    if (popoverController == self.changeSortKeyPopover)
//    {
//    }
}
    
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"orderCell";
    DBOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Order *order = [self.dataSource objectAtIndex:indexPath.row];
    cell.orderDateLabel.text = [DBAppDelegate.sharedInstance.formatter stringFromDate:order.orderDate];
    cell.recieverLabel.text = order.reciever.name;
    NSString *modelsList = @"";
    for (Model *model in order.model)
    {
        modelsList = [modelsList stringByAppendingString:model.name];
        modelsList = [modelsList stringByAppendingString:@", "];
    }
    cell.modelsListLabel.text = [modelsList substringToIndex:modelsList.length-2];
    cell.totalPriceLabel.text = [NSString stringWithFormat:@"%d $",order.totalPrice];
    cell.orderStatusLabel.text = order.status.integerValue == OrderActive ? kStoryboardOrderListCellActive : kStoryboardOrderListCellArchive;
    cell.orderStatusLabel.textColor = order.status.integerValue == OrderActive ? [UIColor redColor] : [UIColor grayColor];
    
    cell.labelModels.text = kStoryboardOrderListCellModels;
    cell.labelReciever.text = kStoryboardOrderListCellReciever;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBOrderDetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Storyboard_Pad" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
    detailViewController.order = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -

- (IBAction)changeSortKey:(id)sender
{
    [self.changeSortKeyPopover presentPopoverFromRect:self.navigationController.toolbar.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
}

- (IBAction)changeModelsInList:(id)sender
{
    [NSUserDefaults.standardUserDefaults setOrderFetchSortKey:kSortOrderKeyDate];
    [self.tableView reloadData];
}

- (IBAction)changeRecieversInList:(id)sender
{
    [self.tableView reloadData];
}

- (IBAction)sortWithReciever:(id)sender
{
    [NSUserDefaults.standardUserDefaults setOrderFetchSortKey:kSortOrderKeyReciever];
    [self.tableView reloadData];
}

- (IBAction)showActive:(id)sender
{
    BOOL showActiveFlag = !NSUserDefaults.standardUserDefaults.showActiveOrders;
    [NSUserDefaults.standardUserDefaults setShowActiveOrders:showActiveFlag];
    self.buttonShowActive.tintColor = showActiveFlag ? [UIColor blackColor] : [UIColor grayColor];
    [self.tableView reloadData];
}

- (IBAction)showArchived:(id)sender
{
    BOOL showArchivedFlag = !NSUserDefaults.standardUserDefaults.showArchivedOrders;
    [NSUserDefaults.standardUserDefaults setShowArchivedOrders:showArchivedFlag];
    self.buttonShowArchived.tintColor = showArchivedFlag ? [UIColor blackColor] : [UIColor grayColor];
    [self.tableView reloadData];
}


@end
