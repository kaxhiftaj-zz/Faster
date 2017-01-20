//
//  ViewController.m
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CLLocationManager *locationManager;
    
    BOOL internet;
    BOOL IS_LOGIN;
    NSMutableDictionary *dictparam;
    
    NSMutableString * strEmail;
    NSMutableString * strPassword;
    NSMutableString * strLogin;
    NSMutableString * strSocialId;
    
}

@end

@implementation ViewController


#pragma mark -
#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    internet=[APPDELEGATE connected];
    if ([CLLocationManager locationServicesEnabled])
    {
        if(internet)
        {
            [self getUserLocation];
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Internet", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    else
    {
        UIAlertView *alertLocation=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enable location access from Setting -> Taxinow Driver -> Privacy -> Location services" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertLocation.tag=100;
        [alertLocation show];
    }
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    dictparam=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    IS_LOGIN=[pref boolForKey:PREF_IS_LOGIN];
    
    if(IS_LOGIN)
    {
        [APPDELEGATE showLoadingWithTitle:NSLocalizedString(@"SIGN_IN", nil)];
       
        strEmail=[pref objectForKey:PREF_EMAIL];
        strPassword=[pref objectForKey:PREF_PASSWORD];
        strLogin=[pref objectForKey:PREF_LOGIN_BY];
        strSocialId=[pref objectForKey:PREF_SOCIAL_ID];
        device_token=[pref objectForKey:PREF_DEVICE_TOKEN];
         [self getSignIn];
        
    }
    else
    {
        self.navigationController.navigationBarHidden=YES;
    }
    
    
    self.navigationController.navigationBarHidden=YES;
}


-(void)viewDidDisappear:(BOOL)animated
{
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    IS_LOGIN=[pref boolForKey:PREF_IS_LOGIN];
    
    if(!IS_LOGIN)
        [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    if(internet)
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
                     [pref setObject:[response valueForKey:@"is_approved"] forKey:PREF_IS_APPROVED];
                     [pref synchronize];
                     
                     
                   //  [APPDELEGATE hideLoadingView];
                     [APPDELEGATE showToastMessage:(NSLocalizedString(@"SIGING_SUCCESS", nil))];
                     [self performSegueWithIdentifier:@"segueToDirectLogin" sender:self];
                     //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"REGISTER_SUCCESS", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                     //            [alert show];
                 }
                 else
                 {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"SIGNIN_FAILED", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }
             
           //  [APPDELEGATE hideLoadingView];
             NSLog(@"REGISTER RESPONSE --> %@",response);
         }];
        
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Internet", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

#pragma mark-
#pragma mark- Get Location

-(void)getUserLocation
{
    [locationManager startUpdatingLocation];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    
#ifdef __IPHONE_8_0
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
        // Use one or the other, not both. Depending on what you put in info.plist
        //[self.locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
#endif
    
    [locationManager startUpdatingLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        struser_lati=[NSString stringWithFormat:@"%.8f",currentLocation.coordinate.latitude];//[NSString stringWithFormat:@"%.8f",22.30];//
        struser_longi=[NSString stringWithFormat:@"%.8f",currentLocation.coordinate.longitude];//[NSString stringWithFormat:@"%.8f",70.78];//
    }
    
    
    // stop updating location in order to save battery power
    [locationManager stopUpdatingLocation];
    
    
    // Reverse Geocoding
    // NSLog(@"Resolving the Address");
    
    // “reverseGeocodeLocation” method to translate the locate data into a human-readable address.
    
    // The reason for using "completionHandler" ----
    //  Instead of using delegate to provide feedback, the CLGeocoder uses “block” to deal with the response. By using block, you do not need to write a separate method. Just provide the code inline to execute after the geocoding call completes.
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         // NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             
             // strAdd -> take bydefault value nil
             NSString *strAdd = nil;
             
             if ([placemark.subThoroughfare length] != 0)
                 strAdd = placemark.subThoroughfare;
             
             if ([placemark.thoroughfare length] != 0)
             {
                 // strAdd -> store value of current location
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                 else
                 {
                     // strAdd -> store only this value,which is not null
                     strAdd = placemark.thoroughfare;
                 }
             }
             
             if ([placemark.postalCode length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                 else
                     strAdd = placemark.postalCode;
             }
             
             if ([placemark.locality length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                 else
                     strAdd = placemark.locality;
             }
             
             if ([placemark.administrativeArea length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                 else
                     strAdd = placemark.administrativeArea;
             }
             
             if ([placemark.country length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                 else
                     strAdd = placemark.country;
                 
             }
             
         }
     }];
}

#pragma mark-
#pragma mark- Alert Button Clicked Event

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if(alertView.tag==100)
        {
            if (buttonIndex == 0)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
               
            }
        }
    
    
}


@end
