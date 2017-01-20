//
//  SettingVC.m
//  UberforX Provider
//
//  Created by My Mac on 11/15/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "SettingVC.h"
#import "PickMeUpMapVC.h"
#import "ArrivedMapVC.h"
#import "FeedBackVC.h"

@interface SettingVC ()
{
    NSMutableString *strUserId;
    NSMutableString *strUserToken;
}

@end

@implementation SettingVC
@synthesize swAvailable,swSound;

- (void)viewDidLoad
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref synchronize];
    strUserId=[pref objectForKey:PREF_USER_ID];
    strUserToken=[pref objectForKey:PREF_USER_TOKEN];
    [super viewDidLoad];
    [self checkState];
    [super setBackBarItem];
    [self customFont];
    
    self.lblAvailable.text = NSLocalizedString(@"Available to drive?", nil);
    //self.lblSound.text=NSLocalizedString(@"ON", nil);
    self.lblSoundtext.text = NSLocalizedString(@"Sound", nil);
    self.lblYes.text = NSLocalizedString(@"YES", nil);
    // Do any additional setup after loading the view.
    
    
    if ([[pref valueForKey:@"SOUND"] isEqualToString:@"off"])
    {
        self.lblSound.text=NSLocalizedString(@"OFF", nil);
        [swSound setOn:NO animated:NO];
    }
    else
    {
        self.lblSound.text=NSLocalizedString(@"ON", nil);
        [swSound setOn:YES animated:NO];
        [pref setObject:@"on" forKey:@"SOUND"];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.btnMenu setTitle:NSLocalizedString(@"Settings", nil) forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.btnMenu setTitle:NSLocalizedString(@"Settings", nil) forState:UIControlStateNormal];
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- customFont

-(void)customFont
{
    self.lblAvailable.font=[UberStyleGuide fontRegular];
    self.lblYes.font=[UberStyleGuide fontRegular];
    self.lblSound.font=[UberStyleGuide fontRegular];
    //self..font=[UberStyleGuide fontRegular];
    self.btnMenu.titleLabel.font=[UberStyleGuide fontRegular];
    
}

-(void)checkState
{
    if([APPDELEGATE connected])
    {
        NSMutableString *pageUrl=[NSMutableString stringWithFormat:@"%@?%@=%@&%@=%@",FILE_CHECKSTATUS,PARAM_ID,strUserId,PARAM_TOKEN,strUserToken];
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:GET_METHOD];
        [afn getDataFromPath:pageUrl withParamData:nil withBlock:^(id response, NSError *error)
         {
             NSLog(@"History Data= %@",response);
             [APPDELEGATE hideLoadingView];
             if (response)
             {
                 if([[response valueForKey:@"success"] intValue]==1)
                 {
                     if([[response valueForKey:@"is_active"] intValue]==1)
                     {
                         swAvailable.on=YES;
                         self.lblYes.text=NSLocalizedString(@"YES", nil);
                     }
                     else
                     {
                         swAvailable.on=NO;
                         self.lblYes.text=NSLocalizedString(@"NO", nil);
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

-(void)setStatus
{
    if([APPDELEGATE connected])
    {
        NSMutableDictionary *dictparam=[[NSMutableDictionary alloc]init];
        
        [dictparam setObject:strUserId forKey:PARAM_ID];
        [dictparam setObject:strUserToken forKey:PARAM_TOKEN];
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:FILE_TOGGLE withParamData:dictparam withBlock:^(id response, NSError *error)
         {
             
             NSLog(@"Request in Progress= %@",response);
             if (response)
             {
                 if([[response valueForKey:@"success"]intValue]==1)
                 {
                     [APPDELEGATE showToastMessage:NSLocalizedString(@"AVAILABILITY_UODATE", nil)];
                 }
             }
             
         }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        else if ([vc isKindOfClass:[PickMeUpMapVC class]])
        {
            obj = (PickMeUpMapVC *)vc;
        }
        
    }
    [self.navigationController popToViewController:obj animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)setState:(id)sender
{
    if ([swAvailable isOn]==NO)
    {
        self.lblYes.text=NSLocalizedString(@"NO", nil);
        
    }
    else
    {
        self.lblYes.text=NSLocalizedString(@"YES", nil);
    }
    [self setStatus];

}

- (IBAction)setSound:(id)sender
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    if ([swSound isOn]==NO)
    {
        self.lblSound.text=NSLocalizedString(@"OFF", nil);
        [pref setObject:@"off" forKey:@"SOUND"];
        
    }
    else
    {
        self.lblSound.text=NSLocalizedString(@"ON", nil);
        [pref setObject:@"on" forKey:@"SOUND"];
    }

}
@end
