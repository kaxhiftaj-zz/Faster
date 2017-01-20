//
//  ContactVC.h
//  UberforX Provider
//
//  Created by My Mac on 11/12/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//



#import "BaseVC.h"


@interface ContactVC : BaseVC <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewContact;
- (IBAction)backBtnPressed:(id)sender;
@property (strong , nonatomic) NSDictionary *dictContact;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

@end
