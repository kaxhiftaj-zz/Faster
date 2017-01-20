//
//  ProfileVC.h
//  UberNewDriver
//
//  Created by My mac on 11/3/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"

@interface ProfileVC : BaseVC <UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtBio;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtReNewPassword;
@property (weak, nonatomic) IBOutlet UIImageView *bgPwd;
@property (weak, nonatomic) IBOutlet UIImageView *bgNewPwd;
@property (weak, nonatomic) IBOutlet UIImageView *bgReNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtTaxiModel;
@property (weak, nonatomic) IBOutlet UITextField *txtTaxiNumber;


@property (weak, nonatomic) IBOutlet UIButton *btnLogOut;
@property (weak, nonatomic) IBOutlet UIButton *btnCountryCode;
- (IBAction)LogOutBtnPressed:(id)sender;
- (IBAction)editBtnPressed:(id)sender;
- (IBAction)updateBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
@property (weak, nonatomic) IBOutlet UIButton *btnProPic;

@property (weak, nonatomic) IBOutlet UIImageView *imgCarModelInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblCarModelInfo;

@property (weak, nonatomic) IBOutlet UIImageView *imgCarNumberInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblCarNumberInfo;

@property (weak, nonatomic) IBOutlet UIImageView *imgEmailInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailInfo;

- (IBAction)imgPicBtnPressed:(id)sender;

- (IBAction)onClickEmailInfo:(id)sender;
- (IBAction)onClickTaxiModelInfo:(id)sender;
- (IBAction)onClickTaxiNoInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnInfo1;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo2;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo3;
@end
