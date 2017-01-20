//
//  ContactVC.m
//  UberforX Provider
//
//  Created by My Mac on 11/12/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "ContactVC.h"
#import "BaseVC.h"
#import "PickMeUpMapVC.h"
#import "ArrivedMapVC.h"
#import "FeedBackVC.h"

@interface ContactVC ()
{
    NSMutableDictionary *dictContact;
}

@end

@implementation ContactVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setBackBarItem];
    self.btnMenu.titleLabel.font=[UberStyleGuide fontRegular];
    //self.btnMenu.titleLabel.text=[self.dictContact valueForKey:@"title"];
    //self.btnMenu.titleLabel.text=[NSString stringWithFormat:@" %@",[self.dictContact valueForKey:@"title"]];
    [self.btnMenu setTitle:[NSString stringWithFormat:@"  %@",[self.dictContact valueForKey:@"title"]] forState:UIControlStateNormal];
    
            [self.webViewContact setDelegate:self];
            NSString *urlAddress =[self.dictContact valueForKey:@"content"];
            [self.webViewContact loadHTMLString:urlAddress baseURL:nil];
    
    
    
    // Do any additional setup after loading the view.
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
