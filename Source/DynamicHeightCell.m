//
//  DynamicHeightCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DynamicHeightCell.h"

@implementation DynamicHeightCell

- (void)awakeFromNib
{
    // Initialization code
    //self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
}

- (void)filleCellWithFeed:(PrayerModel*)feed
{
    self.textlabel.text = feed.title;
    self.contentLabel.text = feed.content;
    //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.contentLabel.preferredMaxLayoutWidth = self.bounds.size.width - 10.0f;
//}
- (void)filleCellWithDetail:(DetailsModel*)feed
{
    self.textlabel.text = feed.title;
    self.contentLabel.text = feed.details;
    //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
    //    [self setNeedsLayout];
    //    [self layoutIfNeeded];
}
@end
