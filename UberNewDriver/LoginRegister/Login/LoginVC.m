//
//  LoginVC.m
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "LoginVC.h"
#import "FacebookUtility.h"
#import <GooglePlus/GooglePlus.h>
#import "GooglePlusUtility.h"
#import "UIImageView+Download.h"
#import "AppDelegate.h"

@interface LoginVC ()
{
    AppDelegate *appDelegate;
    BOOL internet;
    NSMutableArray *arrForCountry;
    NSMutableDictionary *dictparam;
    
    NSString * strEmail;
    NSString * strPassword;
    NSString * strLogin;
    NSMutableString * strSocialId;
    
}


@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - View Life Cycle

@synthesize txtPassword,txtEmail;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setBackBarItem];
    //NSLog(@"fonts: %@", [UIFont familyNames]);
    
    //txtEmail.text=@"nirav.kotecha99@gmail.com";
    //txtPassword.text=@"123456";
    dictparam=[[NSMutableDictionary alloc]init];
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    strEmail=[pref objectForKey:PREF_EMAIL];
    strPassword=[pref objectForKey:PREF_PASSWORD];
    strLogin=[pref objectForKey:PREF_LOGIN_BY];
    strSocialId=[pref objectForKey:PREF_SOCIAL_ID];

    internet=[APPDELEGATE connected];
    
    if(strEmail!=nil)
    {
        [self getSignIn];
    }
    
    [self customFont];
    
    [self.btnSignIn setTitle:NSLocalizedString(@"SIGN IN", nil) forState:UIControlStateNormal];
    
    [self.btnForgotPsw setTitle:NSLocalizedString(@"FORGOT_PASSWORD", nil) forState:UIControlStateNormal];
    
    //[self.btnSignUp setTitle:NSLocalizedString(@"SIGN_UP", nil) forState:UIControlStateNormal];
    
    self.txtEmail.placeholder = NSLocalizedString(@"EMAIL", nil);
    self.txtPassword.placeholder = NSLocalizedString(@"PASSWORD", nil);
    
    //self.txtEmail.placeholder
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [self.btnSignUp setTitle:NSLocalizedString(@"Sign In", nil) forState:UIControlStateNormal];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.btnSignUp setTitle:NSLocalizedString(@"Sign In", nil) forState:UIControlStateNormal];
}
-(void)customFont
{
    self.txtEmail.font=[UberStyleGuide fontRegular];
    self.txtPassword.font=[UberStyleGuide fontRegular];
    
    self.btnForgotPsw.titleLabel.font = [UberStyleGuide fontRegularBold];
    self.btnSignIn.titleLabel.font = [UberStyleGuide fontRegularBold];
    self.btnSignUp.titleLabel.font = [UberStyleGuide fontRegularBold];
    /*
    self.btnSignIn=[APPDELEGATE setBoldFontDiscriptor:self.btnSignIn];
    self.btnForgotPsw=[APPDELEGATE setBoldFontDiscriptor:self.btnForgotPsw];
    self.btnSignUp=[APPDELEGATE setBoldFontDiscriptor:self.btnSignUp];
     */
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
#pragma mark -
#pragma mark - Sign In

-(void)getSignIn
{
    
    if (strEmail==nil)
    {
        NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
        strEmail=[pref objectForKey:PREF_EMAIL];
        strPassword=[pref objectForKey:PREF_PASSWORD];
        strLogin=[pref objectForKey:PREF_LOGIN_BY];
        strSocialId=[pref objectForKey:PREF_SOCIAL_ID];
    }
    if([APPDELEGATE connected])
    {
        [APPDELEGATE showLoadingWithTitle:NSLocalizedString(@"LOADING", nil)];
        
        
        [dictparam setObject:device_token forKey:PARAM_DEVICE_TOKEN];
        [dictparam setObject:@"ios" forKey:PARAM_DEVICE_TYPE];
        [dictparam setObject:strEmail forKey:PARAM_EMAIL];
        
        [dictparam setObject:strLogin forKey:PARAM_LOGIN_BY];
        if (![strLogin isEqualToString:@"manual"])
        {
            [dictparam setObject:strSocialId forKey:PARAM_SOCIAL_ID];

        }
        else
        {
            [dictparam setObject:strPassword forKey:PARAM_PASSWORD];
        }
        
        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:FILE_LOGIN withParamData:dictparam withBlock:^(id response, NSError *error)
         {
             if (response)
             {
                 if([[response valueForKey:@"success"] intValue]==1)
                 {
                     arrUser=response;
                     NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
                     [pref setObject:[response valueForKey:@"token"] forKey:PREF_USER_TOKEN];
                     [pref setObject:[response valueForKey:@"id"] forKey:PREF_USER_ID];
                     [pref setObject:[NSString stringWithFormat:@"%@",device_token] forKey:PREF_DEVICE_TOKEN];
                     
                     [pref setObject:txtEmail.text forKey:PREF_EMAIL];
                     [pref setObject:txtPassword.text forKey:PREF_PASSWORD];
                     [pref setObject:@"manual" forKey:PREF_LOGIN_BY];
                     [pref setBool:YES forKey:PREF_IS_LOGIN];
                     
                     [pref setObject:[response valueForKey:@"is_approved"] forKey:PREF_IS_APPROVED];
                     
                     [pref synchronize];
                     
                     
                     txtPassword.userInteractionEnabled=YES;
                     [APPDELEGATE hideLoadingView];
                     [APPDELEGATE showToastMessage:(NSLocalizedString(@"SIGING_SUCCESS", nil))];
                     [self performSegueWithIdentifier:@"seguetopickme" sender:self];
                     //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"REGISTER_SUCCESS", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                     //            [alert show];
                 }
                 else
                 {
                     
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[response valueForKey:@"error"] delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }
             
             
             [APPDELEGATE hideLoadingView];
             NSLog(@"REGISTER RESPONSE --> %@",response);
         }];
        
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Internet", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
    
}



#pragma mark -
#pragma mark - Button Action

- (IBAction)onClickSignIn:(id)sender
{
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    strEmail=self.txtEmail.text;
    strPassword=self.txtPassword.text;
    strLogin=@"manual";
    
   /* NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref setObject:txtEmail.text forKey:PREF_EMAIL];
    [pref setObject:txtPassword.text forKey:PREF_PASSWORD];
    [pref setObject:@"manual" forKey:PREF_LOGIN_BY];
    [pref setBool:YES forKey:PREF_IS_LOGIN];
    [pref synchronize];
    */
    [self getSignIn];
    
}

- (IBAction)googleBtnPressed:(id)sender
{
    [APPDELEGATE showLoadingWithTitle:@"Please Wait"];
    if([APPDELEGATE connected])
    {
        if ([[GooglePlusUtility sharedObject]isLogin])
        {
            [APPDELEGATE hideLoadingView];

        }
        else
        {
            [[GooglePlusUtility sharedObject]loginWithBlock:^(id response, NSError *error)
             {
                 [APPDELEGATE hideLoadingView];
                 if (response) {
                     NSLog(@"Response ->%@ ",response);
                     txtPassword.userInteractionEnabled=NO;
                     self.txtEmail.text=[response valueForKey:@"email"];
                     
                     NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
                     [pref setObject:txtEmail.text forKey:PREF_EMAIL];
                     [pref setObject:@"google" forKey:PREF_LOGIN_BY];
                     [pref setObject:[response valueForKey:@"userid"] forKey:PREF_SOCIAL_ID];
                     [pref setBool:YES forKey:PREF_IS_LOGIN];
                     [pref synchronize];


                     [self getSignIn];
                 }
             }];
        }
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Internet", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

- (IBAction)facebookBtnPressed:(id)sender
{
    [APPDELEGATE showLoadingWithTitle:@"Please wait"];
    if([APPDELEGATE connected])
    {
        if (![[FacebookUtility sharedObject]isLogin])
        {
            [[FacebookUtility sharedObject]loginInFacebook:^(BOOL success, NSError *error)
             {
                 [APPDELEGATE hideLoadingView];
                 if (success)
                 {
                     
                     NSLog(@"Success");
                     appDelegate = [UIApplication sharedApplication].delegate;
                     [appDelegate userLoggedIn];
                     [[FacebookUtility sharedObject]fetchMeWithFBCompletionBlock:^(id response, NSError *error) {
                         if (response) {
                             NSLog(@"%@",response);
                             self.txtEmail.text=[response valueForKey:@"email"];
                             
                             txtPassword.userInteractionEnabled=NO;
                             txtPassword.text=@"";
                                                          
                             
                             NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
                             [pref setObject:[response valueForKey:@"email"] forKey:PREF_EMAIL];
                             [pref setObject:@"facebook" forKey:PREF_LOGIN_BY];
                             [pref setObject:[response valueForKey:@"id"] forKey:PREF_SOCIAL_ID];
                             [pref setBool:YES forKey:PREF_IS_LOGIN];
                             [pref synchronize];
                             
                             [self getSignIn];
                             
                         }
                     }];
                 }
             }];
        }
        else{
            NSLog(@"User Login Click");
            appDelegate = [UIApplication sharedApplication].delegate;
            [[FacebookUtility sharedObject]fetchMeWithFBCompletionBlock:^(id response, NSError *error) {
                [APPDELEGATE hideLoadingView];

                if (response) {
                    NSLog(@"%@",response);
                    NSLog(@"%@",response);
                    self.txtEmail.text=[response valueForKey:@"email"];
                    txtPassword.userInteractionEnabled=NO;
                    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
                    [pref setObject:[response valueForKey:@"email"] forKey:PREF_EMAIL];
                    [pref setObject:@"facebook" forKey:PREF_LOGIN_BY];
                    [pref setObject:[response valueForKey:@"id"] forKey:PREF_SOCIAL_ID];
                    [pref setBool:YES forKey:PREF_IS_LOGIN];
                    [pref synchronize];
                    [self getSignIn];
                    
                }
            }];
            
            [appDelegate userLoggedIn];
            
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Internet", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)forgotBtnPressed:(id)sender
{
    
}

- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    int y=0;
    if (textField==self.txtEmail)
    {
        y=100;
    }
    else if (textField==self.txtPassword){
        y=150;
    }
    [self.scrLogin setContentOffset:CGPointMake(0, y) animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtEmail)
    {
        [self.txtPassword becomeFirstResponder];
    }
    else if (textField==self.txtPassword){
        [textField resignFirstResponder];
        [self.scrLogin setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}

/*
#pragma mark-
#pragma mark- Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField     //Hide the keypad when we pressed return
{
    if (textField==txtEmail)
    {
        [self.txtPassword becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    if(textField == self.txtPassword)
    {
        UITextPosition *beginning = [self.txtPassword beginningOfDocument];
        [self.txtPassword setSelectedTextRange:[self.txtPassword textRangeFromPosition:beginning
                                                                            toPosition:beginning]];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(0, -35, 320, 480);
            
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
            if(textField == self.txtPassword)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.frame = CGRectMake(0, 0, 320, 568);
                    
                } completion:^(BOOL finished) { }];
            }
            
        }
        else
        {
            
            if(textField == self.txtPassword)
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
