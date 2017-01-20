//
//  JobDoneVC.m
//  UberNewDriver
//
//  Created by Deep Gami on 27/09/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "JobDoneVC.h"

@interface JobDoneVC ()
{
    NSMutableString *strUserId;
    NSMutableString *strUserToken;
    NSMutableString *strRequsetId;
}

@end

@implementation JobDoneVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ////// Set the side bar button action. When it's tapped, it'll show up the sidebar.
    [self.barButton setTarget: self.revealViewController];
    [self.barButton setAction: @selector( revealToggle: )];    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text=@"NAME";
    cell.textLabel.textColor=[UIColor blackColor];
    
    cell.detailTextLabel.text=@"COMMENTS";
    cell.detailTextLabel.textColor=[UIColor blackColor];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.imageView.image=[UIImage imageNamed:@"userimage"];
    return cell;
}

-(void)jobDoneRequest
{
    
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    strUserId=[pref objectForKey:PREF_USER_ID];
    strUserToken=[pref objectForKey:PREF_USER_TOKEN];
    strRequsetId=[pref objectForKey:PREF_REQUEST_ID];
    
    if (strRequsetId!=nil)
    {
        NSMutableDictionary *dictparam=[[NSMutableDictionary alloc]init];
        
        [dictparam setObject:strRequsetId forKey:PARAM_REQUEST_ID];
        [dictparam setObject:strUserId forKey:PARAM_ID];
        [dictparam setObject:strUserToken forKey:PARAM_TOKEN];
        [dictparam setObject:struser_lati forKey:PARAM_LATITUDE];
        [dictparam setObject:struser_longi forKey:PARAM_LONGITUDE];
        [dictparam setObject:@"8" forKey:PARAM_TIME];
        [dictparam setObject:@"5" forKey:PARAM_DISTANCE];

        
        AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
        [afn getDataFromPath:FILE_WALK_COMPLETED withParamData:dictparam withBlock:^(id response, NSError *error)
         {
             
             if([[response valueForKey:@"success"] intValue]==1)
             {
                 [APPDELEGATE showToastMessage:@"Walk Completed"];
             }
         }];
    }

}


- (IBAction)btnPressedJobDone:(id)sender
{
    [self jobDoneRequest];
    [self  performSegueWithIdentifier:@"seguetofeedback" sender:self];
}
@end
