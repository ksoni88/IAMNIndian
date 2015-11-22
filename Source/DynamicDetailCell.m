//
//  DynamicHeightCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DynamicDetailCell.h"

@implementation DynamicDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)filleCellWithFeed:(DetailsModel *)feed
{
    self.textlabel.text = feed.title;
    if([feed.content length]>0){
    self.imageView.imageURL = [NSURL URLWithString:feed.content];
    }
    self.contentLabel.text = feed.details;
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
}
-(void)filleCellWithFeedWithoutImage:(DetailsModel *)feed{
    self.textlabel.text = feed.title;
    //self.imageView.image = feed.image;
    self.imgheightConstraint.constant = 0;
    self.imgTopConstraint.constant = 0;
    self.contentLabel.text = feed.content;
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.contentLabel.preferredMaxLayoutWidth = self.bounds.size.width - 10.0f;
//}
@end
