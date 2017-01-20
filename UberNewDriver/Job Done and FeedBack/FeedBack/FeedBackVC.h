//
//  FeedBackVC.h
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"
#import "RatingBar.h"
#import "SWRevealViewController.h"

@interface FeedBackVC : BaseVC <UITextFieldDelegate,UITextViewDelegate>
{
    RatingBar *ratingView;
}
- (IBAction)submitBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblTask1;
@property (weak, nonatomic) IBOutlet UILabel *lblTask2;
@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;


@property (weak, nonatomic) IBOutlet UITextView *txtComment;


//////////// Outlets Price Label

@property (weak, nonatomic) IBOutlet UILabel *lblBasePrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDistCost;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeCost;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblPerDist;
@property (weak, nonatomic) IBOutlet UILabel *lblPerTime;

@property (weak, nonatomic) IBOutlet UIView *viewForBill;
- (IBAction)confirmBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lblReferrel;

@property (weak, nonatomic) IBOutlet UILabel *lblPromo;


@property (weak, nonatomic) IBOutlet UILabel *lblBase_Price;
@property (weak, nonatomic) IBOutlet UILabel *lblDist_Cost;
@property (weak, nonatomic) IBOutlet UILabel *lblTime_Cost;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalDue;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Referrel;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Promo;
@property (weak, nonatomic) IBOutlet UILabel *lblInvoice;

@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@end
