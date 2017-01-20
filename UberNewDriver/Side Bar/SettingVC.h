//
//  SettingVC.h
//  UberforX Provider
//
//  Created by My Mac on 11/15/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"

@interface SettingVC : BaseVC
@property (weak, nonatomic) IBOutlet UISwitch *swAvailable;
@property (weak, nonatomic) IBOutlet UILabel *lblYes;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)setState:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailable;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)setSound:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *swSound;
@property (weak, nonatomic) IBOutlet UILabel *lblSound;
@property (weak, nonatomic) IBOutlet UILabel *lblSoundtext;

@end
