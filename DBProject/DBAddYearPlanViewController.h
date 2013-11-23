//
//  DBAddYearPlanViewController.h
//  DBProject
//
//  Created by Aleksey Bodnya on 11/23/13.
//  Copyright (c) 2013 abodnya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBAddYearPlanViewController : UIViewController  <UIPopoverControllerDelegate, UIAlertViewDelegate>

- (IBAction)doneCreatingPlan:(id)sender;
- (IBAction)chooseModels:(id)sender;

@end
