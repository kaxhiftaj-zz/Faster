//
//  SideBarVC.m
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "SideBarVC.h"
#import "SWRevealViewController.h"
#import "PickMeUpMapVC.h"
#import "CellSlider.h"
#import "UIView+Utils.h"
#import "UIImageView+Download.h"

@interface SideBarVC ()
{
    NSMutableArray *arrImages,*arrListName;
    NSMutableString *strUserId;
    NSMutableString *strUserToken;
}

@end

@implementation SideBarVC

@synthesize ViewObj;


#pragma mark - Init

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
    internet=[APPDELEGATE connected];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref synchronize];
    strUserId=[pref objectForKey:PREF_USER_ID];
    strUserToken=[pref objectForKey:PREF_USER_TOKEN];
    [self.imgProfilePic applyRoundedCornersFullWithColor:[UIColor whiteColor]];
    [self.imgProfilePic downloadFromURL:[arrUser valueForKey:PREF_USER_PICTURE] withPlaceholder:nil];
    self.lblName.font=[UberStyleGuide fontRegularBold:15];
    self.lblName.text=[NSString stringWithFormat:@"%@ %@",[arrUser valueForKey:@"first_name"],[arrUser valueForKey:@"last_name"]];

    
    arrListName=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"PROFILE",nil),NSLocalizedString(@"History",nil),NSLocalizedString(@"Settings",nil),NSLocalizedString(@"Share",nil),NSLocalizedString(@"About",nil),nil];
    
    arrImages=[[NSMutableArray alloc]initWithObjects:@"nav_profile",@"ub__nav_history",@"nav_referral",@"nav_share",@"",nil];
    
    
    
    NSMutableArray *arrTemp=[[NSMutableArray alloc]init];
    NSMutableArray *arrImg=[[NSMutableArray alloc]init];
    for (int i=0; i<arrPage.count; i++)
    {
        NSMutableDictionary *temp1=[arrPage objectAtIndex:i];
        [arrTemp addObject:[temp1 valueForKey:@"title"]];
        [arrImg addObject:@"nav_support"];
    }
    
    [arrListName addObjectsFromArray:arrTemp];
    [arrImages addObjectsFromArray:arrImg];
    [arrListName addObject:NSLocalizedString(@"LOG OUT", nil)];
    [arrImages addObject:@"ub__nav_logout"];
    
    
    self.navigationItem.leftBarButtonItem=nil;
    
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor=[UIColor clearColor];
}

#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrListName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellSlider *cell=(CellSlider *)[tableView dequeueReusableCellWithIdentifier:@"CellSlider"];
    if (cell==nil) {
        cell=[[CellSlider alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellSlider"];
    }
    cell.lblName.font=[UberStyleGuide fontSemiBold];
    cell.lblName.text=[[arrListName objectAtIndex:indexPath.row]uppercaseString];
    cell.imgIcon.image=[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    
    //[cell setCellData:[arrSlider objectAtIndex:indexPath.row] withParent:self];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([[arrListName objectAtIndex:indexPath.row]isEqualToString:NSLocalizedString(@"LOG OUT", nil)])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"LOG OUT", nil)  message:NSLocalizedString(@"Are Sure You want to log Out", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"NO", nil) otherButtonTitles:NSLocalizedString(@"YES", nil), nil];
        alert.tag=100;
        [alert show];
        
        
        
        return;
    }
    if ([[arrListName objectAtIndex:indexPath.row]isEqualToString:NSLocalizedString(@"Share", nil)])
    {
        NSLog(@"shareButton pressed");
        
        NSString *texttoshare = @"Hello"; //this is your text string to share
        //UIImage *imagetoshare = @""; //this is your image to share
        NSArray *activityItems = @[texttoshare];
        
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
        [self presentViewController:activityVC animated:TRUE completion:nil];

        return;
    }
    
//    if ((indexPath.row >3)&&(indexPath.row<(arrListName.count-1)))
//    {
//        [self.revealViewController rightRevealToggle:self];
//        
//        UINavigationController *nav=(UINavigationController *)self.revealViewController.frontViewController;
//        
//        ViewObj=(PickMeUpMapVC *)[nav.childViewControllers objectAtIndex:0];
//        
//        
//        
//        NSDictionary *dictTemp=[arrPage objectAtIndex:indexPath.row-4];
//              
//        [ViewObj performSegueWithIdentifier:@"contact us" sender:dictTemp];
//        return;
//    }
//    if ([[arrListName objectAtIndex:indexPath.row]isEqualToString:NSLocalizedString(@"About", nil)])
//    {
//        NSLog(@"About us Clicked");
//    }
    

    [self.revealViewController rightRevealToggle:self];
    
    UINavigationController *nav=(UINavigationController *)self.revealViewController.frontViewController;
    
    ViewObj=(PickMeUpMapVC *)[nav.childViewControllers objectAtIndex:0];
    
    if(ViewObj!=nil)
        [ViewObj goToSetting:[[arrListName objectAtIndex:indexPath.row] lowercaseString]];
}

#pragma mark - Alert Button Clicked Event

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 100)
    {
        if (buttonIndex == 1)
        {
            [APPDELEGATE showLoadingWithTitle:NSLocalizedString(@"WAITING_LOGOUT", nil)];
            
            
            if(internet)
            {
                
                    NSMutableDictionary *dictparam=[[NSMutableDictionary alloc]init];
                    
                    [dictparam setObject:strUserId forKey:PARAM_ID];
                    [dictparam setObject:strUserToken forKey:PARAM_TOKEN];
                    
                    AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
                    [afn getDataFromPath:FILE_LOGOUT withParamData:dictparam withBlock:^(id response, NSError *error)
                     {
                         
                         NSLog(@"Log Out= %@",response);
                         [APPDELEGATE hideLoadingView];
                         if (response)
                         {
                             if([[response valueForKey:@"success"] intValue]==1)
                             {
                                 NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
                                 [pref synchronize];
                                 [pref removeObjectForKey:PARAM_REQUEST_ID];
                                 [pref removeObjectForKey:PARAM_SOCIAL_ID];
                                 [pref removeObjectForKey:PREF_EMAIL];
                                 [pref removeObjectForKey:PREF_LOGIN_BY];
                                 [pref removeObjectForKey:PREF_PASSWORD];
                                 [pref removeObjectForKey:PREF_USER_ID];
                                 [pref removeObjectForKey:PREF_USER_TOKEN];
                                 [pref setBool:NO forKey:PREF_IS_LOGIN];
                                 
                                 [pref setObject:@"" forKey:PREF_USER_ID];
                                 [pref setObject:@"" forKey:PREF_USER_TOKEN];
                                 [pref synchronize];
                                 
                                 
                                 
//                                 if ([self.delegate respondsToSelector:@selector(invalidateTimer)])
//                                 {
//                                     [self.delegate invalidateTimer];
//                                 }
                                 
                                 
                                 [self.navigationController   popToRootViewControllerAnimated:YES];
                                 [APPDELEGATE showToastMessage:NSLocalizedString(@"LOGED_OUT", nil)];
                                 
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
    }
}

#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

@end
