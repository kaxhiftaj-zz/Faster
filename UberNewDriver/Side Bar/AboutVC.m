//
//  AboutVC.m
//  UberforX Provider
//
//  Created by My Mac on 11/12/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "AboutVC.h"
#import "PickMeUpMapVC.h"
#import "ArrivedMapVC.h"
#import "FeedBackVC.h"


@interface AboutVC ()
{
    NSMutableDictionary *dictAbout;
}

@end

@implementation AboutVC

#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setBackBarItem];
    self.btnMenu.titleLabel.font=[UberStyleGuide fontRegular];
    
    dictAbout=[[NSMutableDictionary alloc]init];
    for(int i=0;i<arrPage.count;i++)
    {
        dictAbout=[arrPage objectAtIndex:i];
        if ([[dictAbout valueForKey:@"title"]isEqualToString:@"About Us"])
        {
            [self.webViewAbout setDelegate:self];
            NSString *urlAddress =[dictAbout valueForKey:@"content"];
            [self.webViewAbout loadHTMLString:urlAddress baseURL:nil];
        }
    }
}

#pragma mark - ViewLife Cycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Method

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
        
        //changed
        else if ([vc isKindOfClass:[PickMeUpMapVC class]])
        {
            obj = (PickMeUpMapVC *)vc;
        }
        
    }
    [self.navigationController popToViewController:obj animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}
@end
