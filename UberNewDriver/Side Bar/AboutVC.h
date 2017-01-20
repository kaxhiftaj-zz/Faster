//
//  AboutVC.h
//  UberforX Provider
//
//  Created by My Mac on 11/12/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "BaseVC.h"

@interface AboutVC : BaseVC <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewAbout;
- (IBAction)backBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

@end
