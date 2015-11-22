//
//  MuhuratVC.m
//  EAIntroView
//
//  Created by KrunalSoni on 24/07/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//
#import "MuhuratVC.h"
#import "SWRevealViewController.h"
#import "MuhuratTableViewController.h"

@implementation MuhuratVC
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];

    SWRevealViewController* revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sideBarButton setTarget:self.revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning
{
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
- (IBAction)showMuhurats:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;

    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MuhuratTableViewController* controller = (MuhuratTableViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"muhurattb"];
    NSString* datasource = @"vehicle";
    switch (tempBtn.tag) {
    case 1:
        datasource = @"vehicle";
        break;
    case 2:
        datasource = @"property";
        break;
    case 3:
        datasource = @"marriage";
        break;
    default:
        datasource = @"vehicle";
        break;
    }

    controller.dataSourceName = datasource;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
