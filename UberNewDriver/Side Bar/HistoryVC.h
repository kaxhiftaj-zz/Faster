//
//  HistoryVC.h
//  UberforX Provider
//
//  Created by My Mac on 11/15/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"

@interface HistoryVC : BaseVC <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableHistory;
- (IBAction)backBtnPressed:(id)sender;

#pragma mark-
#pragma mark- Payment View

@property (weak, nonatomic) IBOutlet UIView *paymentView;
- (IBAction)closeBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

#pragma mark-
#pragma mark- Base Price Label
@property (weak, nonatomic) IBOutlet UILabel *lblBasePrice;



#pragma mark-
#pragma mark- Distance Price Label

@property (weak, nonatomic) IBOutlet UILabel *lblDistCost;
@property (weak, nonatomic) IBOutlet UILabel *lblPerDist;

#pragma mark-
#pragma mark- Time Price Label

@property (weak, nonatomic) IBOutlet UILabel *lblTimeCost;
@property (weak, nonatomic) IBOutlet UILabel *lblPerTime;

#pragma mark-
#pragma mark- Total Price Label

@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UIImageView *imgNoItems;

@property (weak, nonatomic) IBOutlet UILabel *lblReferrel;
@property (weak, nonatomic) IBOutlet UILabel *lblPromo;

@property (weak, nonatomic) IBOutlet UILabel *lblBase_Price;
@property (weak, nonatomic) IBOutlet UILabel *lblDist_Cost;
@property (weak, nonatomic) IBOutlet UILabel *lblTime_Cost;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalDue;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Referrel;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Promo;
@property (weak, nonatomic) IBOutlet UILabel *lblInvoice;

@end
