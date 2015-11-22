//
//  DynamicHeightCell.h
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayerModel.h"
#import "DetailsModel.h"

@interface DynamicHeightCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

-(void)filleCellWithFeed:(PrayerModel *)feed;
- (void)filleCellWithDetail:(DetailsModel*)feed;
@end
