//
//  MuhuratVC.h
//  EAIntroView
//
//  Created by KrunalSoni on 24/07/15.
//  Copyright (c) 2015 SampleCorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MuhuratVC : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem* sideBarButton;
@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;
- (IBAction)showMuhurats:(id)sender;

@end
