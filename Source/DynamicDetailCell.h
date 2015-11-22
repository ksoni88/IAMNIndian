//
//  DynamicHeightCell.h
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsModel.h"
#import "AsyncImageView.h"

@interface DynamicDetailCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgheightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgTopConstraint;

-(void)filleCellWithFeed:(DetailsModel *)feed;
-(void)filleCellWithFeedWithoutImage:(DetailsModel *)feed;
@end
