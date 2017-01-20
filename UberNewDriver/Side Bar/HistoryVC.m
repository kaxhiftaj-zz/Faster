//
//  HistoryVC.m
//  UberforX Provider
//
//  Created by My Mac on 11/15/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "HistoryVC.h"
#import "HistoryCell.h"
#import "UIImageView+Download.h"
#import "UtilityClass.h"
#import "PickMeUpMapVC.h"
#import "ArrivedMapVC.h"
#import "FeedBackVC.h"

@interface HistoryVC ()
{
    NSMutableArray *arrHistory;
    NSMutableString *strUserId;
    NSMutableString *strUserToken;
    NSMutableArray *arrForDate;
    NSMutableArray *arrForSection;
   
    

    BOOL internet;
}

@end

@implementation HistoryVC

@synthesize tableHistory;


#pragma mark-
#pragma mark- View Delegate Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setBackBarItem];
    arrHistory=[[NSMutableArray alloc]init];
    [self customFont];
    [self localizeString];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    internet=[APPDELEGATE connected];
    [self.paymentView setHidden:YES];
    
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref synchronize];
    strUserId=[pref objectForKey:PREF_USER_ID];
    strUserToken=[pref objectForKey:PREF_USER_TOKEN];
    [APPDELEGATE showLoadingWithTitle:NSLocalizedString(@"LOADING_HISTORY", nil)];
    [self getHistory];
    self.imgNoItems.hidden=YES;
    self.navigationController.navigationBarHidden=NO;
    [self.btnMenu setTitle:NSLocalizedString(@"History", nil) forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.btnMenu setTitle:NSLocalizedString(@"History", nil) forState:UIControlStateNormal];
}

#pragma mark-
#pragma mark- customFont

-(void)customFont
{
//    self.lblBasePrice.font=[UberStyleGuide fontRegular];
//    self.lblDistCost.font=[UberStyleGuide fontRegular];
//    self.lblPerDist.font=[UberStyleGuide fontRegular];
//    self.lblPerTime.font=[UberStyleGuide fontRegular];
//    self.lblTimeCost.font=[UberStyleGuide fontRegular];
    //self.lblTotal.font=[UberStyleGuide fontRegular:30.0f];
    
    self.btnMenu.titleLabel.font=[UberStyleGuide fontRegular];
    self.btnClose=[APPDELEGATE setBoldFontDiscriptor:self.btnClose];
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
    
    
    [self.btnClose setTitle:NSLocalizedString(@"CLOSE", nil) forState:UIControlStateNormal];
    [self.btnClose setTitle:NSLocalizedString(@"CLOSE", nil) forState:UIControlStateSelected];
    
}

#pragma mark-
#pragma mark- Get History API Method



-(void)getHistory
{
    if(internet)
    {
        NSMutableString *pageUrl=[NSMutableString stringWithFormat:@"%@?%@=%@&%@=%@",FILE_HISTORY,PARAM_ID,strUserId,PARAM_TOKEN,strUserToken];
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        [afn getDataFromPath:pageUrl withParamData:nil withBlock:^(id response, NSError *error)
         {
             
             NSLog(@"History Data= %@",response);
             
             [APPDELEGATE hideLoadingView];
             if (response)
             {
                 if([[response valueForKey:@"success"] intValue]==1)
                 {
                     arrHistory=[response valueForKey:@"requests"];
                     if (arrHistory.count==0)
                     {
                         self.imgNoItems.hidden=NO;
                         self.tableHistory.hidden=YES;
                     }
                     else
                     {
                         [self makeSection];
                         self.imgNoItems.hidden=YES;
                         self.tableHistory.hidden=NO;
                         [tableHistory reloadData];
                     }
                 }
             }
             
         }];
        
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Internet", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


#pragma mark-
#pragma mark- Table View Delegate

-(void)makeSection
{
    arrForDate=[[NSMutableArray alloc]init];
    arrForSection=[[NSMutableArray alloc]init];
    NSMutableArray *arrtemp=[[NSMutableArray alloc]init];
    [arrtemp addObjectsFromArray:arrHistory];
    NSSortDescriptor *distanceSortDiscriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO
                                                                              selector:@selector(localizedStandardCompare:)];
    
    [arrtemp sortUsingDescriptors:@[distanceSortDiscriptor]];
    
    for (int i=0; i<arrtemp.count; i++)
    {
        NSMutableDictionary *dictDate=[[NSMutableDictionary alloc]init];
        dictDate=[arrtemp objectAtIndex:i];
        
        NSString *temp=[dictDate valueForKey:@"date"];
        NSArray *arrDate=[temp componentsSeparatedByString:@" "];
        NSString *strdate=[arrDate objectAtIndex:0];
        if(![arrForDate containsObject:strdate])
        {
            [arrForDate addObject:strdate];
        }
        
    }
    
    for (int j=0; j<arrForDate.count; j++)
    {
        NSMutableArray *a=[[NSMutableArray alloc]init];
        [arrForSection addObject:a];
    }
    for (int j=0; j<arrForDate.count; j++)
    {
        NSString *strTempDate=[arrForDate objectAtIndex:j];
        
        for (int i=0; i<arrtemp.count; i++)
        {
            NSMutableDictionary *dictSection=[[NSMutableDictionary alloc]init];
            dictSection=[arrtemp objectAtIndex:i];
            NSArray *arrDate=[[dictSection valueForKey:@"date"] componentsSeparatedByString:@" "];
            NSString *strdate=[arrDate objectAtIndex:0];
            if ([strdate isEqualToString:strTempDate])
            {
                [[arrForSection objectAtIndex:j] addObject:dictSection];
                
            }
        }
        
    }
    
    
}


    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[arrForSection objectAtIndex:section] count];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrForSection.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
    UILabel *lblDate=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 20)];
    lblDate.font=[UberStyleGuide fontRegular];
    lblDate.textColor=[UberStyleGuide colorDefault];
    NSString *strDate=[arrForDate objectAtIndex:section];
    NSString *current=[[UtilityClass sharedObject] DateToString:[NSDate date] withFormate:@"yyyy-MM-dd"];
    
    
    ///   YesterDay Date Calulation
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    NSDate *yesterday = [gregorian dateByAddingComponents:dayComponent
                                                   toDate:[NSDate date]
                                                  options:0];
    NSString *strYesterday=[[UtilityClass sharedObject] DateToString:yesterday withFormate:@"yyyy-MM-dd"];
    
    
    if([strDate isEqualToString:current])
    {
        lblDate.text=NSLocalizedString(@"Today", nil);
        headerView.backgroundColor=[UberStyleGuide colorDefault];
        lblDate.textColor=[UIColor whiteColor];
         lblDate.font=[UberStyleGuide fontRegular];
    }
    else if ([strDate isEqualToString:strYesterday])
    {
        lblDate.text=NSLocalizedString(@"Yesterday", nil);
         lblDate.font=[UberStyleGuide fontRegular];
    }
    else
    {
        NSDate *date=[[UtilityClass sharedObject]stringToDate:strDate withFormate:@"yyyy-MM-dd"];
        NSString *text=[[UtilityClass sharedObject]DateToString:date withFormate:@"dd MMMM yyyy"];//2nd Jan 2015
        lblDate.text=text;
         lblDate.font=[UberStyleGuide fontRegular];
    }
    
    [headerView addSubview:lblDate];
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSMutableDictionary *pastDict=[[arrForSection objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        NSMutableDictionary *dictOwner=[pastDict valueForKey:@"owner"];
    
        static NSString *CellIdentifier = @"Cell";
    
        HistoryCell *cell = [tableHistory dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[HistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    cell.lblName.font=[UberStyleGuide fontRegularBold:12.0f];
    cell.lblCost.font=[UberStyleGuide fontRegular:20.0f];
    cell.lblType.font=[UberStyleGuide fontRegular];
    
    
    NSDate *dateTemp=[[UtilityClass sharedObject]stringToDate:[pastDict valueForKey:@"date"]];
    NSString *strDate=[[UtilityClass sharedObject]DateToString:dateTemp withFormate:@"hh:mm a"];
    cell.lblDateTime.text=[NSString stringWithFormat:@"%@",strDate];
    //cell.lblDateTime.font=[UberStyleGuide fontRegular];
    cell.lblName.text=[NSString stringWithFormat:@"%@ %@",[dictOwner valueForKey:@"first_name"],[dictOwner valueForKey:@"last_name"]];
    cell.lblType.text=[NSString stringWithFormat:@"%@",[dictOwner valueForKey:@"phone"]];
    cell.lblCost.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"total"] floatValue]];
    
    [cell.imgOwner downloadFromURL:[dictOwner valueForKey:@"picture"] withPlaceholder:nil];
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationController.navigationBarHidden=YES;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *pastDict=[[arrForSection objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
   
    self.lblBasePrice.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"base_price"] floatValue]];
    self.lblDistCost.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"distance_cost"] floatValue]];
    self.lblTimeCost.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"time_cost"] floatValue]];
    self.lblTotal.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"total"] floatValue]];
    self.lblPromo.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"promo_bonus"] floatValue]];
    self.lblReferrel.text=[NSString stringWithFormat:@"$%.2f",[[pastDict valueForKey:@"referral_bonus"] floatValue]];
    
    
    float totalDist=[[pastDict valueForKey:@"distance_cost"] floatValue];
    float Dist=[[pastDict valueForKey:@"distance"]floatValue];
    
    if ([[pastDict valueForKey:@"unit"]isEqualToString:NSLocalizedString(@"kms", nil)])
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
    
    float totalTime=[[pastDict valueForKey:@"time_cost"] floatValue];
    float Time=[[pastDict valueForKey:@"time"]floatValue];
    if(Time!=0)
    {
        self.lblPerTime.text=[NSString stringWithFormat:@"%.2f$ %@",(totalTime/Time),NSLocalizedString(@"per mins", nil)];
    }
    else
    {
        self.lblPerTime.text=[NSString stringWithFormat:@"0$ %@",NSLocalizedString(@"per mins", nil)];
    }
        
    

    [self.paymentView setHidden:NO];

}



#pragma mark-
#pragma mark- Button Method


- (IBAction)backBtnPressed:(id)sender
{
    NSArray *currentControllers = self.navigationController.viewControllers;
    NSMutableArray *newControllers = [NSMutableArray
                                      arrayWithArray:currentControllers];
    UIViewController *obj=nil;
    
    for (int i=0; i<newControllers.count; i++)
    {
        UIViewController *vc=[self.navigationController.viewControllers objectAtIndex:i];
        if ([vc isKindOfClass:[FeedBackVC class]])
        {
            obj = (FeedBackVC *)vc;
        }
        else if ([vc isKindOfClass:[ArrivedMapVC class]])
        {
            obj = (ArrivedMapVC *)vc;
        }
        //changed
        else if ([vc isKindOfClass:[PickMeUpMapVC class]])
        {
            obj = (PickMeUpMapVC *)vc;
        }
        
    }
    [self.navigationController popToViewController:obj animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)closeBtnPressed:(id)sender
{
    self.navigationController.navigationBarHidden=NO;
    [self.paymentView setHidden:YES];
}
@end
