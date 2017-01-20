//
//  TermsVC.m
//  SG Taxi
//
//  Created by My Mac on 12/5/14.
//  Copyright (c) 2014 Jigs. All rights reserved.
//

#import "TermsVC.h"

@interface TermsVC ()

@end

@implementation TermsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setBackBarItem];
    [APPDELEGATE showLoadingWithTitle:@"Please Wait"];
    NSURL *websiteUrl = [NSURL URLWithString:PRIVACY_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webViewTerms loadRequest:urlRequest];
    
    self.btnNavigation.titleLabel.font=[UberStyleGuide fontRegular];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.btnNavigation setTitle:NSLocalizedString(@"Terms & Conditions", nil) forState:UIControlStateNormal];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [APPDELEGATE hideLoadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
