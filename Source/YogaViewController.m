//
//  YogaViewController.m
//  EAIntroView
//
//  Created by KrunalSoni on 09/08/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import "YogaViewController.h"
#import "SWRevealViewController.h"
@implementation YogaViewController
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamindian@3x"]];
    SWRevealViewController* revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sideBarButton setTarget:self.revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
@end
