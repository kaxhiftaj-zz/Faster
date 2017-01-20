//
//  ForgotPasswordVC.h
//  UberforX Provider
//
//  Created by My Mac on 11/15/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"

@interface ForgotPasswordVC : BaseVC<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)forgotBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnForget;

@end
