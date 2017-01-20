//
//  JobDoneVC.h
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"
#import "SWRevealViewController.h"


@interface JobDoneVC : BaseVC
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnPressedJobDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
