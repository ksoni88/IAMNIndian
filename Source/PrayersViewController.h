//
//  ViewController.h
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrayersViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem* sideBarButton;
@property (assign) BOOL isFestivalDetailsView;
@property (assign) BOOL isCeremonyDetailsView;
@property (assign) BOOL isHolyPlaceDetailsView;
@property (assign) BOOL isFoodDetailsView;
@property (assign) BOOL isPrayersView;
@property (strong, nonatomic) NSString* idString;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (strong, nonatomic) NSString *header;
@end
