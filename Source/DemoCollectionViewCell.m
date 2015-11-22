//
//  EBCardCollectionViewCell.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "DemoCollectionViewCell.h"

#define kHorizontalOffset 10

@implementation DemoCollectionViewCell

#pragma mark - Properties

- (void)setPerson:(Person*)person
{
    _person = person;
    _personImageView.imageURL = [NSURL URLWithString:_person.avatarFilename];
    _personNameLabel.text = _person.name;
    _description.text = _person.desc;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@3x"]];
}

@end
