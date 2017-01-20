//
//  AppDelegate.h
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#define Google_Key @"AIzaSyDGmc05Efv7ZFkdUVVwn4CjN1U62UfVrRY"

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView   *viewLoading;
- (void)userLoggedIn;
- (NSString *)applicationCacheDirectoryString;

-(void) showHUDLoadingView:(NSString *)strTitle;
-(void) hideHUDLoadingView;
-(void)showToastMessage:(NSString *)message;
+(AppDelegate *)sharedAppDelegate;
-(void)showLoadingWithTitle:(NSString *)title;
-(void)hideLoadingView;
- (BOOL)connected;

-(id)setBoldFontDiscriptor:(id)objc;

@end
