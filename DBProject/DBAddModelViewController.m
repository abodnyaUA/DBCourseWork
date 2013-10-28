//
//  DBAddModelViewController.m
//  DBProject
//
//  Created by abodnya on 10/29/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import "DBAddModelViewController.h"
#import "DBModelsListViewController.h"

@interface DBAddModelViewController ()

@property (weak, nonatomic) DBModelsListViewController * parent;

@end

@implementation DBAddModelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewControllerChange:)
                                                 name:@"UINavigationControllerWillShowViewControllerNotification"
                                               object:self.navigationController];
	// Do any additional setup after loading the view.
}
- (IBAction)doneClicked:(id)sender
{
    [DBAppDelegate.sharedInstance.manager addModelWithName:self.nameTextField.text andCost:[self.priceTextField.text integerValue]];
    [self.parent update];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewControllerChange:(NSNotification*)notification
{
    if ([[notification.userInfo objectForKey:@"UINavigationControllerLastVisibleViewController"] isKindOfClass:DBModelsListViewController.class])
    {
        self.parent = [notification.userInfo objectForKey:@"UINavigationControllerLastVisibleViewController"];
    }
    else
    {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
