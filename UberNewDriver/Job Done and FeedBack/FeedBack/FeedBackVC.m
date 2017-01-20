//
//  FeedBackVC.m
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//
#import "FeedBackVC.h"
#import "UIImageView+Download.h"
#import "UIView+Utils.h"

@interface FeedBackVC ()
{
    NSMutableString *strUserId;
    NSMutableString *strUserToken;
    NSMutableString *strRequsetId;
    
    NSString *strTime;
    NSString *strDistance;
    NSString *strProfilePic;
    NSString *strLastName;
    NSString *strFirstName;
    int rate;
}

@end

@implementation FeedBackVC

@synthesize txtComment;

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
    
    [self customFont];
    [self localizeString];
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    strDistance=[pref objectForKey:PREF_WALK_DISTANCE];
    strTime=[pref objectForKey:PREF_WALK_TIME];
    strProfilePic=[pref objectForKey:PREF_USER_PICTURE];
    strLastName=[pref objectForKey:PREF_USER_NAME];
    
    
    NSArray *myWords = [strLastName componentsSeparatedByString:@" "];
    
    self.lblFirstName.text=[myWords objectAtIndex:0];
    self.lblLastName.text=[myWords objectAtIndex:1];
    [self.imgProfile applyRoundedCornersFullWithColor:[UIColor whiteColor]];
    //self.lblDistance.text=[NSString stringWithFormat:@"%@ %@",strDistance,NSLocalizedString(@"Miles", nil)];
    self.lblDistance.text=[NSString stringWithFormat:@"%.2f %@",[[dictBillInfo valueForKey:@"distance"] floatValue],[dictBillInfo valueForKey:@"unit"]];
    self.lblTime.text=[NSString stringWithFormat:@"%@ %@",strTime,NSLocalizedString(@"Mins", nil)];
    self.lblTask1.text=@"0";
    self.lblTask2.text=@"1";
    [self.imgProfile downloadFromURL:strProfilePic withPlaceholder:nil];
    
    [self.btnMenu addTarget:self.revealViewController action:@selector(revealToggle: ) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
//    ratingView=[[RatingBar alloc] initWithSize:CGSizeMake (120, 20) AndPosition:CGPointMake(178, 152)];
//    ratingView.backgroundColor=[UIColor clearColor];
//    
//    
//    [self.view addSubview:ratingView];
    
    self.viewForBill.hidden=NO;
    [self setPriceValue];
    
    // Do any additional setup after loading the view.
}

/*- (IBAction)onClickMenu:(id)sender{
    [self.revealViewController revealToggle:sender];
}*/

- (void)viewWillAppear:(BOOL)animated
{
    [self.btnMenu setTitle:NSLocalizedString(@"Feedback", nil) forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [APPDELEGATE hideLoadingView];
    [self.btnMenu setTitle:NSLocalizedString(@"Feedback", nil) forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)giveFeedback
{
    
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    strUserId=[pref objectForKey:PREF_USER_ID];
    strUserToken=[pref objectForKey:PREF_USER_TOKEN];
    strRequsetId=[pref objectForKey:PREF_REQUEST_ID];
    
    if (strRequsetId!=nil)
    {
        NSMutableDictionary *dictparam=[[NSMutableDictionary alloc]init];
        
        [dictparam setObject:strRequsetId forKey:PARAM_REQUEST_ID];
        [dictparam setObject:strUserId forKey:PARAM_ID];
        [dictparam setObject:strUserToken forKey:PARAM_TOKEN];
        
        [dictparam setObject:[NSString stringWithFormat:@"%d",rate] forKey:PARAM_RATING];
        
        NSString *commt=self.txtComment.text;
        if([commt isEqualToString:NSLocalizedString(@"COMMENTS", nil)])
        {
            [dictparam setObject:@"" forKey:PARAM_COMMENT];
        }
        else
        {
            [dictparam setObject:self.txtComment.text forKey:PARAM_COMMENT];
        }
        
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:FILE_RATING withParamData:dictparam withBlock:^(id response, NSError *error)
         {
             
             [APPDELEGATE hideLoadingView];
             if([[response valueForKey:@"success"] intValue]==1)
             {
                 [APPDELEGATE showToastMessage:NSLocalizedString(@"RATING_COMPLETED", nil)];
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_REQUEST_ID];
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_USER_NAME];
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_USER_PHONE];
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_USER_PICTURE];
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_USER_RATING];
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_START_TIME];
                 is_completed=0;
                 is_dog_rated=0;
                 is_started=0;
                 is_walker_arrived=0;
                 is_walker_started=0;
                 [self.navigationController popToRootViewControllerAnimated:YES];
                 
             }
         }];
    }
}

#pragma mark-
#pragma mark-

-(void)customFont
{
    self.lblTime.font=[UberStyleGuide fontRegular];
    self.lblDistance.font=[UberStyleGuide fontRegular];
    self.lblTask1.font=[UberStyleGuide fontRegular];
    self.lblTask2.font=[UberStyleGuide fontRegular];
    self.lblFirstName.font=[UberStyleGuide fontRegular];
    self.lblLastName.font=[UberStyleGuide fontRegular];
    
    self.btnMenu.titleLabel.font=[UberStyleGuide fontRegular];
    self.btnSubmit=[APPDELEGATE setBoldFontDiscriptor:self.btnSubmit];
}

-(void)localizeString
{
    self.lblInvoice.text = NSLocalizedString(@"Invoice", nil);
    self.lblTime_Cost.text = NSLocalizedString(@"TIME COST", nil);
    self.lblDist_Cost.text = NSLocalizedString(@"DISTANCE COST", nil);
    self.lblTotalDue.text = NSLocalizedString(@"Total Due", nil);
    self.lblBasePrice.text = NSLocalizedString(@"BASE PRICE", nil);
    self.lbl_Promo.text = NSLocalizedString(@"PROMO BOUNCE", nil);
    self.lbl_Referrel.text = NSLocalizedString(@"REFERRAL BOUNCE", nil);
    
    [self.btnConfirm setTitle:NSLocalizedString(@"CONFIRM", nil) forState:UIControlStateNormal];
    [self.btnSubmit setTitle:NSLocalizedString(@"SUBMIT", nil) forState:UIControlStateNormal];
    [self.btnSubmit setTitle:NSLocalizedString(@"SUBMIT", nil) forState:UIControlStateSelected];
    
    
    
    self.lblComment.text = NSLocalizedString(@"COMMENT", nil);
    self.txtComment.text = NSLocalizedString(@"COMMENTS", nil);
    
}
#pragma mark-
#pragma mark- Set Invoice Details

-(void)setPriceValue
{
    self.lblReferrel.text = [NSString stringWithFormat:@"$ %.2f",[[dictBillInfo valueForKey:@"referral_bonus"] floatValue]];
    self.lblPromo.text = [NSString stringWithFormat:@"$ %.2f",[[dictBillInfo valueForKey:@"promo_bonus"] floatValue]];
    self.lblBasePrice.text=[NSString stringWithFormat:@"$ %.2f",[[dictBillInfo valueForKey:@"base_price"] floatValue]];
    self.lblDistCost.text=[NSString stringWithFormat:@"$ %.2f",[[dictBillInfo valueForKey:@"distance_cost"] floatValue]];
    self.lblTimeCost.text=[NSString stringWithFormat:@"$ %.2f",[[dictBillInfo valueForKey:@"time_cost"] floatValue]];
    self.lblTotal.text=[NSString stringWithFormat:@"$ %.2f",[[dictBillInfo valueForKey:@"total"] floatValue]];
    
    float totalDist=[[dictBillInfo valueForKey:@"distance_cost"] floatValue];
    float Dist=[[dictBillInfo valueForKey:@"distance"]floatValue];
    
    if ([[dictBillInfo valueForKey:@"unit"]isEqualToString:NSLocalizedString(@"kms", nil)])
    {
        totalDist=totalDist*0.621317;
        Dist=Dist*0.621371;
    }
    if(Dist!=0)
    {
        self.lblPerDist.text=[NSString stringWithFormat:@"%.2f$ %@",(totalDist/Dist),NSLocalizedString(@"per mile", nil)];
        
    }
    else
    {
        
        self.lblPerDist.text=[NSString stringWithFormat:@"0$ %@",NSLocalizedString(@"per mile", nil)];
    }
    
    float totalTime=[[dictBillInfo valueForKey:@"time_cost"] floatValue];
    float Time=[[dictBillInfo valueForKey:@"time"]floatValue];
    if(Time!=0)
    {
        self.lblPerTime.text=[NSString stringWithFormat:@"%.2f$ %@",(totalTime/Time),NSLocalizedString(@"per mins", nil)];
    }
    else
    {
        self.lblPerTime.text=[NSString stringWithFormat:@"0$ %@",NSLocalizedString(@"per mins", nil)];
    }
    
//    self.lblPerTime.text=[NSString stringWithFormat:@"%.2f$ per Mins",[[dictBillInfo valueForKey:@"price_per_unit_time"] floatValue]];
//    
//    float unitTime=[[dictBillInfo valueForKey:@"price_per_unit_time"] floatValue];
//    float Time=[[dictBillInfo valueForKey:@"time"]floatValue];
//    if(Time!=0)
//    {
//        self.lblTimeCost.text=[NSString stringWithFormat:@"$ %.2f",(unitTime*Time)];
//    }
//    else
//    {
//        self.lblTimeCost.text=[NSString stringWithFormat:@"$ %.2f",(unitTime*Time)];
//    }

    
}


#pragma mark-
#pragma mark- Bytton Methods
- (IBAction)submitBtnPressed:(id)sender
{
    RBRatings rating=[ratingView getcurrentRatings];
    rate=rating/2.0;
    if (rate==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"PLEASE_RATINGS", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:Nil, nil];
        [alert show];
    }
    else
    {
        [APPDELEGATE showLoadingWithTitle:NSLocalizedString(@"WAITING_FOR_FEEDBACK", nil)];
        [txtComment resignFirstResponder];
        [self giveFeedback];
    }
    
    
}

- (IBAction)confirmBtnPressed:(id)sender
{
    self.viewForBill.hidden=YES;
    ratingView=[[RatingBar alloc] initWithSize:CGSizeMake(120, 20) AndPosition:CGPointMake(145, 150)];
    ratingView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:ratingView];
    
    
}

#pragma mark-
#pragma mark- Text Field Delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtComment resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField     //Hide the keypad when we pressed return
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
   
    self.txtComment.text=@"";
    UIDevice *thisDevice=[UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 568)
        {
            if(textView == self.txtComment)
            {
                UITextPosition *beginning = [self.txtComment beginningOfDocument];
                [self.txtComment setSelectedTextRange:[self.txtComment textRangeFromPosition:beginning
                                                                                  toPosition:beginning]];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.frame = CGRectMake(0, -210, 320, 568);
                    
                } completion:^(BOOL finished) { }];
            }
        }
        else
        {
            if(textView == self.txtComment)
            {
                UITextPosition *beginning = [self.txtComment beginningOfDocument];
                [self.txtComment setSelectedTextRange:[self.txtComment textRangeFromPosition:beginning
                                                                                  toPosition:beginning]];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.frame = CGRectMake(0, -210, 320, 480);
                    
                } completion:^(BOOL finished) { }];
            }
        }
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    UIDevice *thisDevice=[UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 568)
        {
            if(textView == self.txtComment)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.frame = CGRectMake(0, 0, 320, 568);
                    
                } completion:^(BOOL finished) { }];
            }
        }
        else
        {
            if(textView == self.txtComment)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.frame = CGRectMake(0, 0, 320, 480);
                    
                } completion:^(BOOL finished) { }];
            }
        }
    }
    if ([txtComment.text isEqualToString:@""])
    {
        txtComment.text=NSLocalizedString(@"COMMENTS", nil);;
    }
    
}

/*- (void)textFieldDidBeginEditing:(UITextField *)textField
 
 {
 if(textField == self.txtComment)
 {
 UITextPosition *beginning = [self.txtComment beginningOfDocument];
 [self.txtComment setSelectedTextRange:[self.txtComment textRangeFromPosition:beginning
 toPosition:beginning]];
 [UIView animateWithDuration:0.3 animations:^{
 
 self.view.frame = CGRectMake(0, -120, 320, 480);
 
 } completion:^(BOOL finished) { }];
 }
 }
 
 - (void)textFieldDidEndEditing:(UITextField *)textField
 {
 UIDevice *thisDevice=[UIDevice currentDevice];
 if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
 {
 CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
 
 if (iOSDeviceScreenSize.height == 568)
 {
 if(textField == self.txtComment)
 {
 [UIView animateWithDuration:0.3 animations:^{
 
 self.view.frame = CGRectMake(0, 0, 320, 568);
 
 } completion:^(BOOL finished) { }];
 }
 }
 else
 {
 if(textField == self.txtComment)
 {
 [UIView animateWithDuration:0.3 animations:^{
 
 self.view.frame = CGRectMake(0, 0, 320, 480);
 
 } completion:^(BOOL finished) { }];
 }
 }
 }
 }
 */



@end
